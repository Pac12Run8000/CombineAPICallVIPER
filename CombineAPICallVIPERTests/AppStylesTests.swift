import XCTest
import SwiftUI
@testable import CombineAPICallVIPER

final class AppStylesTests: XCTestCase {

    func testTextFieldPadding() {
        // Given
        let expectedPadding: CGFloat = 10
        
        // Then
        XCTAssertEqual(AppStyles.textFieldPadding, expectedPadding, "AppStyles.textFieldPadding should be equal to \(expectedPadding)")
    }

    func testButtonPadding() {
        // Given
        let expectedPadding: CGFloat = 10
        
        // Then
        XCTAssertEqual(AppStyles.buttonPadding, expectedPadding, "AppStyles.buttonPadding should be equal to \(expectedPadding)")
    }

    func testCornerRadius() {
        // Given
        let expectedRadius: CGFloat = 8
        
        // Then
        XCTAssertEqual(AppStyles.cornerRadius, expectedRadius, "AppStyles.cornerRadius should be equal to \(expectedRadius)")
    }
}
