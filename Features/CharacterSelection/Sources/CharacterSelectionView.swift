//
//  CharacterSelectionView.swift
//  CthulhuCharacterSheet
//
//  Created by Bartek Pichalski on 06/11/2022.
//

import SwiftUI
import CommonUI

public struct CharacterSelectionView: View {

	// MARK: - Initialization

	public init() {}

	// MARK: - View

    public var body: some View {
		VStack {
			headerRow(imageName: "test")
			ScrollView(.vertical, showsIndicators: false) {
				screenDescription
//				systemCharacters(
//					charactersFull: viewStore.charactersFull,
//					selectAction: { viewStore.send(.selectCharacter($0)) }
//				)
			}.padding(.horizontal, Margin.large)
			Spacer()
		}
		.ignoresSafeArea()
    }

	private func headerRow(imageName: String) ->  some View {
		ZStack {
			Rectangle()
				.fill(LinearGradient(
					gradient: .init(colors: [Color.appLightPurple, Color.appDarkPurple]),
					startPoint: .init(x: 0.0, y: 0),
					endPoint: .init(x: 1.0, y: 1.0)
				)).frame(height: 242)
			VStack {
				HStack {
					Image(imageName, bundle: CommonUIResources.bundle)
						.padding(.top, Margin.extraLarge)
					Spacer()
				}
			}
		}
	}

	var screenDescription: some View {
		VStack {
			Group {
//				SectionHeaderView(title: L10n.characterListTitle)
//					.padding(.top, Margin.large)
				Text(L10n.characterListDescription)
					.textStyle(.greyRegular)
					.padding(.top, Margin.micro)
			}
//			.fullWidth(alignment: .leading)
		}
	}
//
//	private func systemCharacters(
//		charactersFull: [CharactersPerSystem],
//		selectAction: @escaping (Character) -> Void
//	) ->  some View {
//		VStack {
//			ForEach(charactersFull) { item in
//				SectionHeaderView(title: item.system.name)
//				ForEach(item.characters) { character in
//					Button(action: { selectAction(character) }) {
//						InfoTileView(
//							image: Image(character.imageName, bundle: CommonUIResources.bundle),
//							title: character.name,
//							description: character.description
//						)
//						.defaultCard()
//					}.padding(.top, Margin.regular)
//				}
//			}
//		}
//	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterSelectionView()
    }
}
