import SwiftUI

class TVShowSearchRouter: TVShowSearchRouterProtocol {
    
    func navigateToDetails(for show: Result) {
        // Handle navigation to details view
        print("Navigating to details for: \(show.name)")
    }

    static func createModule() -> some View {
        let service = TVShowServiceImpl(baseURL: URLConstants.buildTVUrl()!, bearerToken: "Bearer Token")
        let interactor = TVShowSearchInteractor(service: service)
        let router = TVShowSearchRouter()
        let presenter = TVShowSearchPresenter(interactor: interactor, router: router)
        return ContentView(presenter: presenter)
    }
}
