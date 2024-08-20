import Combine
import Foundation

final class TVShowServiceImpl: TVShowServiceProtocol {
    private let baseURL: URL
    private let bearerToken: String
    private let session: URLSession

    init(baseURL: URL, bearerToken: String, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.bearerToken = bearerToken
        self.session = session
    }

    func fetchTVShowSearch(query: String) -> AnyPublisher<TVShowSearch, Error> {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
        components.queryItems = [URLQueryItem(name: "query", value: query)]

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")

        return session.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: TVShowSearch.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

