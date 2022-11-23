import SwiftUI
import MainAttributes

@main
struct MainAttributesApp: App {
    var body: some Scene {
        WindowGroup {
            MainAttributesView(
                store: .init(initialState: MainAttributes.State(character: .mock), reducer: MainAttributes())
			)
        }
    }
}
