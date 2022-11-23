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
                    SectionHeaderView(title: "Informacje podstawowe")
                    BasicInfoView(
                        name: viewStore.character.inestigatorData.name,
                        profession: viewStore.character.inestigatorData.occupation.value,
                        professionImageName: viewStore.character.inestigatorData.occupation.imageName,
                        time: viewStore.character.inestigatorData.time.displayName
                    )
                    SectionHeaderView(title: "Wygląd")
                    AppearanceView(
                        characterImageName: "tmpCharacter",
                        address: viewStore.character.inestigatorData.adress,
                        birthAddress: viewStore.character.inestigatorData.birthPlace,
                        age: viewStore.character.inestigatorData.age.value,
                        sex: viewStore.character.inestigatorData.sex,
                        description: viewStore.character.history.personalDescription,
                        changeAvatarAction: {}
                    )
                    SectionHeaderView(title: "Statystyki")
                    LazyVGrid(
                        columns: [
                            .init(.flexible()),
                            .init(.flexible()),
                            .init(.flexible())
                        ],
                        spacing: Margin.small
                    ) {
                        CircleCardView(title: "\(viewStore.character.characteristics.strenght)", description: "Strenght")
                        CircleCardView(title: "\(viewStore.character.characteristics.constitution)", description: "Constitution")
                        CircleCardView(title: "\(viewStore.character.characteristics.dexternity)", description: "Dexternity")
                        CircleCardView(title: "\(viewStore.character.characteristics.inteligence)", description: "Inteligence")
                        CircleCardView(title: "\(viewStore.character.characteristics.size)", description: "Size")
                        CircleCardView(title: "\(viewStore.character.characteristics.power)", description: "Power")
                        CircleCardView(title: "\(viewStore.character.characteristics.apperance)", description: "Apperance")
                        CircleCardView(title: "\(viewStore.character.characteristics.education)", description: "Education")
                    }
                    SectionHeaderView(title: "Historia")
                    VStack(spacing: Margin.medium) {
                        HistoryTile(title: "Traits", description: viewStore.character.history.traits)
                        HistoryTile(title: "Ideology & Beliefs", description: viewStore.character.history.ideologyBeliefs)
                        HistoryTile(title: "Injures & Scars", description: viewStore.character.history.injuriesScars)
                        HistoryTile(title: "Significant People", description: viewStore.character.history.significantPeople)
                        HistoryTile(title: "Phobias & Manias", description: viewStore.character.history.phobiasManias)
                        HistoryTile(title: "Meaningfull Locations", description: viewStore.character.history.meaningfulLocations)
                        HistoryTile(title: "Arcane tomes and Spells", description: viewStore.character.history.arcaneTomesSpells)
                        HistoryTile(title: "Treasured Possessions", description: viewStore.character.history.treasuredPossessions)
                        HistoryTile(title: "Encounters With Strange Entities", description: viewStore.character.history.encountersWithStrangeEntities)
                    }
                    Text("Aby edytować dowolny kafelek należy na niego dotknąć.")
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
