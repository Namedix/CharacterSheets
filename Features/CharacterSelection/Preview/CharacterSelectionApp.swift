import SwiftUI
import CharacterSelection

@main
struct CharacterSelectionApp: App {
    var body: some Scene {
        WindowGroup {
			CharacterSelectionView(
				store: .init(
					initialState: CharacterSelection.State(characters: [.mock]),
					reducer: CharacterSelection()
				)
			)
        }
    }
}
