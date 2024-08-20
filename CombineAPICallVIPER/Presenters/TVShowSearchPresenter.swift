import Combine
import Foundation

class TVShowSearchPresenter: ObservableObject, TVShowSearchPresenterProtocol {
    @Published var tvShowSearch: TVShowSearch?  // Holds the search results
    @Published var error: Error?  // Tracks any errors during the search process
    
    private let interactor: TVShowSearchInteractorProtocol
    private let router: TVShowSearchRouterProtocol
    private var cancellables = Set<AnyCancellable>()

    init(interactor: TVShowSearchInteractorProtocol, router: TVShowSearchRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }

    func searchTVShows(query: String) {
        interactor.searchTVShows(query: query)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.error = error
                }
            }, receiveValue: { [weak self] tvShowSearch in
                self?.tvShowSearch = tvShowSearch
            })
            .store(in: &cancellables)
    }

    func didSelectShow(_ show: Result) {
        router.navigateToDetails(for: show)
    }
}
