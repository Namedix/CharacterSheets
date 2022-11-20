//
//  CharacterSelection.swift
//  CharacterSelection
//
//  Created by Bartek Pichalski on 09/11/2022.
//  Copyright © 2022 com.rook. All rights reserved.
//

import Common
import ComposableArchitecture
import Foundation
import Tabs

public struct CharacterSelection: ReducerProtocol {
    // MARK: - Properties

    public struct State: Equatable {
        // MARK: - Properties

        var characters: [CthulhuCharacter]
        var tabsState: Tabs.State?
        var randomCharacterImageName: String {
            characters.randomElement()?.inestigatorData.appearanceImageName ?? Constants.defaultImageName
        }

        // MARK: - Initialization

        public init(characters: [CthulhuCharacter]) {
            self.characters = characters
        }
    }

    public enum Action: Equatable {
        case didSelectCharacter(CthulhuCharacter?)
        case tabs(Tabs.Action)
    }

    // MARK: - Initialization

    public init() {}

    // MARK: - Composable Architecture

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case let .didSelectCharacter(character):
                state.tabsState = character == nil ? nil : .init(character: character!)
                return .none
            case .tabs(.misc(.changeCharacter)):
                state.tabsState = nil
                return .none
            case .tabs:
                return .none
            }
        }.ifLet(\.tabsState, action: /Action.tabs) {
            Tabs()
        }
    }
}

extension CharacterSelection {
    enum Constants {
        static let defaultImageName: String = "characterReporter"
    }
}
