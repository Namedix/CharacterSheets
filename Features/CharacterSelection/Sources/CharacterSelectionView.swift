//
//  CharacterSelectionView.swift
//  CthulhuCharacterSheet
//
//  Created by Bartek Pichalski on 06/11/2022.
//

import Common
import CommonUI
import ComposableArchitecture
import SwiftUI

public struct CharacterSelectionView: View {
    // MARK: - Properties

    var store: StoreOf<CharacterSelection>

    // MARK: - Initialization

    public init(store: StoreOf<CharacterSelection>) {
        self.store = store
    }

    // MARK: - View

    public var body: some View {
        WithViewStore(self.store) { viewStore in
            GeometryReader { proxy in
                VStack(spacing: 0) {
                    headerRow(imageName: viewStore.randomCharacterImageName)
                        .frame(height: proxy.size.height / 3)
                    ScrollView(.vertical, showsIndicators: false) {
                        screenDescription
                        systemCharacters(
                            characters: viewStore.characters,
                            selectAction: { _ in }
                        )
                    }.padding(.horizontal, Margin.large)
                    Spacer()
                }
                .ignoresSafeArea()
                .background(color: .appBlackDark)
            }
        }
    }

    private func headerRow(imageName: String) -> some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: .init(colors: [Color.appLightPurple, Color.appDarkPurple]),
                        startPoint: .init(x: 0.0, y: 0),
                        endPoint: .init(x: 1.0, y: 1.0)
                    )
                )
            VStack {
                Spacer()
                HStack {
                    Image(imageName, bundle: CommonUIResources.bundle)
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea(edges: .top)
                    Spacer()
                }
            }
        }
    }

    var screenDescription: some View {
        VStack {
            Group {
                SectionHeaderView(title: L10n.characterListTitle)
                    .padding(.top, Margin.large)
                Text(L10n.characterListDescription)
                    .textStyle(.greyRegular)
                    .padding(.top, Margin.micro)
            }
            .fullWidth(alignment: .leading)
        }
    }

    private func systemCharacters(
        characters: [CthulhuCharacter],
        selectAction _: @escaping (Character) -> Void
    ) -> some View {
        VStack {
            SectionHeaderView(title: "Cthulhu")
            ForEach(characters) { character in
                Button(action: {}) {
                    InfoTileView(
                        image: Image(character.inestigatorData.occupation.imageName, bundle: CommonUIResources.bundle),
                        title: character.inestigatorData.name,
                        description: character.inestigatorData.occupation.value
                    )
                    .defaultCard()
                }.padding(.top, Margin.regular)
            }
        }
    }
}

#if DEBUG
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            CharacterSelectionView(
                store: Store(
                    initialState: .init(characters: [.mock]),
                    reducer: CharacterSelection()
                )
            )
        }
    }
#endif
