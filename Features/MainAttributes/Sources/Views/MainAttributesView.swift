import SwiftUI
import Common
import CommonUI
import ComposableArchitecture

public struct MainAttributesView: View {

    // MARK: - Properties

    var store: StoreOf<MainAttributes>

    // MARK: - Initialization

    public init(store: StoreOf<MainAttributes>) {
		self.store = store
    }

    // MARK: - View

    public var body: some View {
        WithViewStore(self.store) { viewStore in
            ScrollView(showsIndicators: false) {
                VStack {
                    SectionHeaderView(title: L10n.mainAttributesStandardInformationHeader)
                    BasicInfoView(
                        name: viewStore.character.inestigatorData.name,
                        profession: viewStore.character.inestigatorData.occupation.value,
                        professionImageName: viewStore.character.inestigatorData.occupation.imageName,
                        time: viewStore.character.inestigatorData.time.displayName
                    )
                    SectionHeaderView(title: L10n.mainAttributesApperanceHeader)
                    AppearanceView(
                        characterImageName: "tmpCharacter",
                        address: viewStore.character.inestigatorData.adress,
                        birthAddress: viewStore.character.inestigatorData.birthPlace,
                        age: viewStore.character.inestigatorData.age.value,
                        sex: viewStore.character.inestigatorData.sex,
                        description: viewStore.character.history.personalDescription,
                        changeAvatarAction: {}
                    )
                    SectionHeaderView(title: L10n.mainAttributesStatisticHeader)
                    LazyVGrid(
                        columns: [
                            .init(.flexible()),
                            .init(.flexible()),
                            .init(.flexible())
                        ],
                        spacing: Margin.small
                    ) {
                        CircleCardView(title: "\(viewStore.character.characteristics.strenght)", description: L10n.mainAttributesStrenght)
                        CircleCardView(title: "\(viewStore.character.characteristics.constitution)", description: L10n.mainAttributesConstitution)
                        CircleCardView(title: "\(viewStore.character.characteristics.dexternity)", description: L10n.mainAttributesDexternity)
                        CircleCardView(title: "\(viewStore.character.characteristics.inteligence)", description: L10n.mainAttributesInteligence)
                        CircleCardView(title: "\(viewStore.character.characteristics.size)", description: L10n.mainAttributesSize)
                        CircleCardView(title: "\(viewStore.character.characteristics.power)", description: L10n.mainAttributesPower)
                        CircleCardView(title: "\(viewStore.character.characteristics.apperance)", description: L10n.mainAttributesApperance)
                        CircleCardView(title: "\(viewStore.character.characteristics.education)", description: L10n.mainAttributesEducation)
                    }
                    SectionHeaderView(title: L10n.mainAttributesHistoryHeader)
                    VStack(spacing: Margin.medium) {
                        HistoryTile(title: L10n.mainAttributesTraits, description: viewStore.character.history.traits)
                        HistoryTile(title: L10n.mainAttributesIdeology, description: viewStore.character.history.ideologyBeliefs)
                        HistoryTile(title: L10n.mainAttributesInjures, description: viewStore.character.history.injuriesScars)
                        HistoryTile(title: L10n.mainAttributesSignificant, description: viewStore.character.history.significantPeople)
                        HistoryTile(title: L10n.mainAttributesPhobias, description: viewStore.character.history.phobiasManias)
                        HistoryTile(title: L10n.mainAttributesMeaningfull, description: viewStore.character.history.meaningfulLocations)
                        HistoryTile(title: L10n.mainAttributesArcaneTomes, description: viewStore.character.history.arcaneTomesSpells)
                        HistoryTile(title: L10n.mainAttributesTreasuredPossessions, description: viewStore.character.history.treasuredPossessions)
                        HistoryTile(title: L10n.mainAttributesEncounters, description: viewStore.character.history.encountersWithStrangeEntities)
                    }
                    Text(L10n.mainAttributesHistoryTooltip)
                        .textStyle(.greyTinyRegular)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, Margin.large)
                }
            }
            .padding(.horizontal, Margin.medium)
            .background(color: .appBlackDark)
        }
    }
}

#if DEBUG
struct WorkspaceView_Previews: PreviewProvider {
    static var previews: some View {
        MainAttributesView(
			store: Store(
                initialState: .init(character: .mock),
				reducer: MainAttributes()
			)
        )
    }
}
#endif
