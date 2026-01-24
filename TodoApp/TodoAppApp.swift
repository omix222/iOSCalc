import SwiftUI

@main
struct TodoAppApp: App {
    @State private var viewModel = TodoViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(viewModel)
        }
    }
}
