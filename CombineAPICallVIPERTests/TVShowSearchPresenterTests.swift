import XCTest
import Combine
@testable import CombineAPICallVIPER

class MockTVShowSearchRouter: TVShowSearchRouterProtocol {
    var didNavigateToDetails = false
    var selectedShow: Result?

    func navigateToDetails(for show: Result) {
        didNavigateToDetails = true
        selectedShow = show
    }
}

class MockTVShowSearchInteractor: TVShowSearchInteractorProtocol {
    var resultToReturn: AnyPublisher<TVShowSearch, Error>!
    
    func searchTVShows(query: String) -> AnyPublisher<TVShowSearch, Error> {
        return resultToReturn
    }
}

final class TVShowSearchPresenterTests: XCTestCase {
    var presenter: TVShowSearchPresenter!
    var mockInteractor: MockTVShowSearchInteractor!
    var mockRouter: MockTVShowSearchRouter!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockInteractor = MockTVShowSearchInteractor()
        mockRouter = MockTVShowSearchRouter()
        presenter = TVShowSearchPresenter(interactor: mockInteractor, router: mockRouter)
        cancellables = []
    }

    override func tearDownWithError() throws {
        mockInteractor = nil
        mockRouter = nil
        presenter = nil
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
        
        mockInteractor.resultToReturn = Just(expectedResult)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()

        let expectation = XCTestExpectation(description: "tvShowSearch should be updated")

        // When
        presenter.$tvShowSearch
            .dropFirst()
            .sink { tvShowSearch in
                // Then
                XCTAssertEqual(tvShowSearch?.page, expectedResult.page)
                XCTAssertEqual(tvShowSearch?.results.count, expectedResult.results.count)
                XCTAssertEqual(tvShowSearch?.results.first?.originalName, "Breaking Bad")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        presenter.searchTVShows(query: "Breaking Bad")
        wait(for: [expectation], timeout: 1.0)
    }

    func testSearchTVShowsFailure() {
        // Given
        let expectedError = URLError(.badServerResponse)
        mockInteractor.resultToReturn = Fail(error: expectedError)
            .eraseToAnyPublisher()

        let expectation = self.expectation(description: "Error should be handled")

        // When
        presenter.$error
            .dropFirst()
            .sink { error in
                // Then
                XCTAssertNotNil(error, "Error should be set on failure")
                XCTAssertEqual((error as? URLError)?.code, expectedError.code)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        presenter.searchTVShows(query: "Breaking Bad")
        wait(for: [expectation], timeout: 1.0)
    }

    func testDidSelectShow() {
        // Given
        let selectedShow = Result(
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
        
        // When
        presenter.didSelectShow(selectedShow)

        // Then
        XCTAssertTrue(mockRouter.didNavigateToDetails, "Router should have navigated to details")
        
        if let actualSelectedShow = mockRouter.selectedShow {
                XCTAssertEqual(actualSelectedShow, selectedShow, "Router should navigate to the correct show details")
            } else {
                XCTFail("Selected show should not be nil")
            }
    }
}
