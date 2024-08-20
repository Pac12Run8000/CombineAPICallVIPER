import SwiftUI

@main
struct CombineAPICallVIPERApp: App {
    var body: some Scene {
        WindowGroup {
            TVShowSearchRouter.createModule()
        }
    }
}
