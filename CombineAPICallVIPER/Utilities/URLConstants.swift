import Foundation

class URLConstants {
    static func buildTVUrl() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/search/tv"
        return components.url
    }
}
