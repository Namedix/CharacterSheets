import SwiftUI
import Tabs

@main
struct CthulhuCharacterSheetApp: App {
    var body: some Scene {
        WindowGroup {
            TabsView(
                store: .init(initialState: Tabs.State(character: .mock), reducer: Tabs())
            )
        }
    }
}
