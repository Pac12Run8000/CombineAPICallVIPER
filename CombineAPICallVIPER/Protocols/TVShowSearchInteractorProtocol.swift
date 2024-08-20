import Combine

protocol TVShowSearchInteractorProtocol {
    func searchTVShows(query: String) -> AnyPublisher<TVShowSearch, Error>
}
