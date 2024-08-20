import XCTest
@testable import CombineAPICallVIPER

final class TVShowSearchRouterTests: XCTestCase {

    func testNavigateToDetails() {
        // Given
        let router = TVShowSearchRouter()
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
        let expectation = self.expectation(description: "Should navigate to details")

        router.navigateToDetailsHandler = { show in
            XCTAssertEqual(show, selectedShow, "Should navigate to the correct show details")
            expectation.fulfill()
        }

        router.navigateToDetails(for: selectedShow)

        // Then
        wait(for: [expectation], timeout: 1.0)
    }
}
