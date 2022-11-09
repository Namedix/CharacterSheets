//
//  CharacterSelection.swift
//  CharacterSelection
//
//  Created by Bartek Pichalski on 09/11/2022.
//  Copyright © 2022 com.rook. All rights reserved.
//

import Foundation
import Common
import ComposableArchitecture

public struct CharacterSelection: ReducerProtocol {

	// MARK: - Properties

	public struct State: Equatable {

		// MARK: - Properties

		let characters: [CthulhuCharacter]
		var randomCharacterImageName: String {
			characters.randomElement()?.inestigatorData.appearanceImageName ?? Constants.defaultImageName
		}

		// MARK: - Initialization

		public init(characters: [CthulhuCharacter]) {
			self.characters = characters
		}
	}

	public enum Action: Equatable {
		case didSelectCharacter(CthulhuCharacter)
	}

	// MARK: - Initialization

	public init() {}

	// MARK: - Composable Architecture

	public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
		switch action {
		case .didSelectCharacter:
			// TODO: - Navigate to Tabs
			return .none
		}
	}
}

extension CharacterSelection {
	enum Constants {
		static let defaultImageName: String = "characterReporter"
	}
}
