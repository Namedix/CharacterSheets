//
//  CthulhuCharacterSheetApp.swift
//  CthulhuCharacterSheet
//
//  Created by Bartek Pichalski on 06/11/2022.
//

import CharacterSelection
import SwiftUI

@main
struct CthulhuCharacterSheetApp: App {
    var body: some Scene {
        WindowGroup {
            CharacterSelectionView(
                store: .init(
                    initialState: CharacterSelection.State(
                        characters: [.mock]
                    ),
                    reducer: CharacterSelection()
                )
            )
        }
    }
}
