import SwiftUI

class TVShowSearchRouter: TVShowSearchRouterProtocol {
    
    func navigateToDetails(for show: Result) {
        // Handle navigation to details view
        print("Navigating to details for: \(show.name)")
    }

    static func createModule() -> some View {
        let service = TVShowServiceImpl(baseURL: URLConstants.buildTVUrl()!, bearerToken: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYWZmMGYyYTJlMDUxOTMyNzk2ODYxZGI2YTI0NmQ3NSIsIm5iZiI6MTcyMzEzMjM1Mi40Mzk0MDEsInN1YiI6IjU5MzY5N2UyOTI1MTQxNmJlZTAwZDA2ZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.sWoqEyowmKf8SCNvfbJnyF2ZM3HO34IdfCXDl9TdKEc")
        let interactor = TVShowSearchInteractor(service: service)
        let router = TVShowSearchRouter()
        let presenter = TVShowSearchPresenter(interactor: interactor, router: router)
        return ContentView(presenter: presenter)
    }
}
