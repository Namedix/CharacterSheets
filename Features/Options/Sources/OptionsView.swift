import CommonUI
import ComposableArchitecture
import SwiftUI

public struct OptionsView: View {
    // MARK: - Properties

    var store: StoreOf<Options>

    // MARK: - Initialization

    public init(store: StoreOf<Options>) {
        self.store = store
    }

    // MARK: - View

    public var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                InfoTileView(
                    image: .rulesIcon,
                    title: L10n.optionsRulesTitle,
                    description: L10n.optionsRulesDescription
                ).defaultCard()
                InfoTileView(
                    image: .dicesIcon,
                    title: L10n.optionsDicesTitle,
                    description: L10n.optionsDicesDescription
                ).defaultCard()
                Spacer()
                Button(action: { viewStore.send(.changeCharacter) }) {
                    InfoTileView(
                        image: .changeCharacterIcon,
                        title: L10n.optionsChangeCharacterTitle,
                        description: L10n.optionsChangeCharacterDescription
                    ).defaultCard()
                }
            }
            .padding(Margin.large)
            .background(color: .appBlackDark)
        }
    }
}

#if DEBUG
    struct WorkspaceView_Previews: PreviewProvider {
        static var previews: some View {
            OptionsView(
                store: Store(
                    initialState: .init(),
                    reducer: Options()
                )
            )
        }
    }
#endif
