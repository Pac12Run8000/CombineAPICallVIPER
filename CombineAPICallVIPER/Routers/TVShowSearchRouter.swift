import SwiftUI

class TVShowSearchRouter: TVShowSearchRouterProtocol {
    var navigateToDetailsHandler: ((Result) -> Void)?

    func navigateToDetails(for show: Result) {
        navigateToDetailsHandler?(show)
    }

    static func createModule() -> some View {
        let service = TVShowServiceImpl(baseURL: URLConstants.buildTVUrl()!, bearerToken: "Bearer Token")
        let interactor = TVShowSearchInteractor(service: service)
        let router = TVShowSearchRouter()
        let presenter = TVShowSearchPresenter(interactor: interactor, router: router)
        return ContentView(presenter: presenter)
    }
}
