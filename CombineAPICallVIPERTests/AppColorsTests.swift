import XCTest
import SwiftUI
@testable import CombineAPICallVIPER

final class AppColorsTests: XCTestCase {

    func testDarkColor() {
        // Given
        let expectedColor = Color(UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00))
        
        // Then
        XCTAssertEqual(AppColors.darkColor, expectedColor, "AppColors.darkColor should match the expected dark color")
    }

    func testLightGrayColor() {
        // Given
        let expectedColor = Color(UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1.00))
        
        // Then
        XCTAssertEqual(AppColors.lightGrayColor, expectedColor, "AppColors.lightGrayColor should match the expected light gray color")
    }

    func testBlueColor() {
        // Given
        let expectedColor = Color(UIColor(red: 0.25, green: 0.35, blue: 0.85, alpha: 1.00))
        
        // Then
        XCTAssertEqual(AppColors.blueColor, expectedColor, "AppColors.blueColor should match the expected blue color")
    }

    func testWhiteColor() {
        // Then
        XCTAssertEqual(AppColors.whiteColor, Color.white, "AppColors.whiteColor should be equal to Color.white")
    }

    func testBlackColor() {
        // Then
        XCTAssertEqual(AppColors.blackColor, Color.black, "AppColors.blackColor should be equal to Color.black")
    }
}
