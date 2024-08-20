import Combine
@testable import CombineAPICallVIPER

class MockTVShowSearchPresenter: TVShowSearchPresenter {
    var didCallSearchTVShows = false
    var selectedShow: Result?

    override func searchTVShows(query: String) {
        didCallSearchTVShows = true
    }

    override func didSelectShow(_ show: Result) {
        selectedShow = show
    }
}
