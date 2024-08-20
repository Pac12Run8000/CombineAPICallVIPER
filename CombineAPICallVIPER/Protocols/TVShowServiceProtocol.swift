import Combine
import Foundation

protocol TVShowServiceProtocol {
    func fetchTVShowSearch(query: String) -> AnyPublisher<TVShowSearch, Error>
}

