import Combine

protocol TVShowSearchPresenterProtocol: AnyObject {
    var tvShowSearch: TVShowSearch? { get set }
    var error: Error? { get set }
    
    func searchTVShows(query: String)
    func didSelectShow(_ show: Result)
}
