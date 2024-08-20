//
//  TVShowSearchInteractorTests.swift
//  CombineAPICallVIPERTests
//
//  Created by Norbert Grover on 8/19/24.
//

import XCTest
import Combine
@testable import CombineAPICallVIPER

class MockTVShowService: TVShowServiceProtocol {
    var resultToReturn: AnyPublisher<TVShowSearch, Error>!

    func fetchTVShowSearch(query: String) -> AnyPublisher<TVShowSearch, Error> {
        return resultToReturn
    }
}

final class TVShowSearchInteractorTests: XCTestCase {
    var interactor: TVShowSearchInteractor!
    var mockService: MockTVShowService!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockService = MockTVShowService()
        interactor = TVShowSearchInteractor(service: mockService)
        cancellables = []
    }

    override func tearDownWithError() throws {
        mockService = nil
        interactor = nil
        cancellables = nil
        try super.tearDownWithError()
    }

    func testSearchTVShowsSuccess() {
        // Given
        let expectedResult = TVShowSearch(
            page: 1,
            results: [
                Result(
                    adult: false,
                    backdropPath: "/path_to_backdrop.jpg",
                    genreIDS: [18, 80],
                    id: 12345,
                    originCountry: ["US"],
                    originalLanguage: "en",
                    originalName: "Breaking Bad",
                    overview: "A high school chemistry teacher turned methamphetamine producer...",
                    popularity: 100.0,
                    posterPath: "/path_to_poster.jpg",
                    firstAirDate: "2008-01-20",
                    name: "Breaking Bad",
                    voteAverage: 9.5,
                    voteCount: 5000
                )
            ],
            totalPages: 1,
            totalResults: 1
        )

        mockService.resultToReturn = Just(expectedResult)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()

        let expectation = XCTestExpectation(description: "Should receive TVShowSearch result")

        // When
        interactor.searchTVShows(query: "Breaking Bad")
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success but got failure with \(error)")
                }
            }, receiveValue: { tvShowSearch in
                // Then
                XCTAssertEqual(tvShowSearch.page, expectedResult.page)
                XCTAssertEqual(tvShowSearch.results.count, expectedResult.results.count)
                XCTAssertEqual(tvShowSearch.results.first?.originalName, "Breaking Bad")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testSearchTVShowsFailure() {
        // Given
        let expectedError = URLError(.badServerResponse)
        mockService.resultToReturn = Fail(error: expectedError)
            .eraseToAnyPublisher()

        let expectation = XCTestExpectation(description: "Should receive an error")

        // When
        interactor.searchTVShows(query: "Breaking Bad")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Expected failure but got success")
                case .failure(let error):
                    // Then
                    XCTAssertEqual((error as? URLError)?.code, expectedError.code)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure but got a value")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}
