import Foundation
import Combine

class MockTVShowSearchInteractor: TVShowSearchInteractorProtocol {
    var resultToReturn: AnyPublisher<TVShowSearch, Error>!

    func searchTVShows(query: String) -> AnyPublisher<TVShowSearch, Error> {
        return resultToReturn
    }
}
