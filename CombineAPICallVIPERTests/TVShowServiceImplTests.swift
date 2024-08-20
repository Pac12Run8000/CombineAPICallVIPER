import XCTest
import Combine
@testable import CombineAPICallVIPER

final class TVShowServiceImplTests: XCTestCase {
    var cancellables: Set<AnyCancellable>!
    var mockURLSession: URLSession!

    override func setUpWithError() throws {
        try super.setUpWithError()
        cancellables = []
        
        // Setup mock URLSession with MockURLProtocol
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        mockURLSession = URLSession(configuration: configuration)
    }

    override func tearDownWithError() throws {
        cancellables = nil
        mockURLSession = nil
        try super.tearDownWithError()
    }

    func testFetchTVShowSearchSuccess() throws {
        // Given
        let expectedURL = "https://api.themoviedb.org/3/search/tv?query=Breaking%20Bad"
        let baseURL = URL(string: "https://api.themoviedb.org/3/search/tv")!
        let bearerToken = "dummyToken"
        let service = TVShowServiceImpl(baseURL: baseURL, bearerToken: bearerToken, session: mockURLSession)

        // Mock response
        let mockResponse = TVShowSearch(
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

        // Setup the request handler
        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.url?.absoluteString, expectedURL)
            XCTAssertEqual(request.value(forHTTPHeaderField: "Authorization"), "Bearer \(bearerToken)")

            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let data = try! JSONEncoder().encode(mockResponse)
            return (response, data)
        }

        // When
        let expectation = XCTestExpectation(description: "Fetch TV show search")
        service.fetchTVShowSearch(query: "Breaking Bad")
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success but got failure with \(error)")
                }
            }, receiveValue: { tvShowSearch in
                // Then
                XCTAssertEqual(tvShowSearch.page, 1)
                XCTAssertEqual(tvShowSearch.results.count, 1)
                XCTAssertEqual(tvShowSearch.results.first?.originalName, "Breaking Bad")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }
}
