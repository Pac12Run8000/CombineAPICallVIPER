import Combine

class TVShowSearchInteractor: TVShowSearchInteractorProtocol {
    private let service: TVShowServiceProtocol
    
    init(service: TVShowServiceProtocol) {
        self.service = service
    }
    
    func searchTVShows(query: String) -> AnyPublisher<TVShowSearch, Error> {
        return service.fetchTVShowSearch(query: query)
    }
}
