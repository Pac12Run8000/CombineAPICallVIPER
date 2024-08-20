import Foundation

class MockTVShowSearchRouter: TVShowSearchRouterProtocol {
    var didNavigateToDetails = false
    var selectedShow: Result?

    func navigateToDetails(for show: Result) {
        didNavigateToDetails = true
        selectedShow = show
    }
}
