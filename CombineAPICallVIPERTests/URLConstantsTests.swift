import XCTest
@testable import CombineAPICallVIPER

final class URLConstantsTests: XCTestCase {
    
    func testBuildTVUrl() {
        // Given
        let expectedURLString = "https://api.themoviedb.org/3/search/tv"
        
        // When
        let url = URLConstants.buildTVUrl()
        
        // Then
        XCTAssertNotNil(url, "The URL should not be nil")
        XCTAssertEqual(url?.absoluteString, expectedURLString, "The URL is not correctly constructed")
    }
}
