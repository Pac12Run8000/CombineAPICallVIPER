import XCTest
import SwiftUI
import Combine
@testable import CombineAPICallVIPER

final class ContentViewTests: XCTestCase {
    var mockPresenter: MockTVShowSearchPresenter!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let mockInteractor = MockTVShowSearchInteractor()
        let mockRouter = MockTVShowSearchRouter()
        
        mockPresenter = MockTVShowSearchPresenter(interactor: mockInteractor, router: mockRouter)
        cancellables = []
    }

    override func tearDownWithError() throws {
        mockPresenter = nil
        cancellables = nil
        try super.tearDownWithError()
    }
}
