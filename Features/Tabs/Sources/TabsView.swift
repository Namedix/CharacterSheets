import CommonUI
import ComposableArchitecture
import Equipment
import Options
import SwiftUI
import MainAttributes

public struct TabsView: View {
    // MARK: - Properties

    var store: StoreOf<Tabs>

    // MARK: - Initialization

    public init(store: StoreOf<Tabs>) {
        self.store = store
    }

    // MARK: - View

    public var body: some View {
        WithViewStore(self.store) { _ in
            TabView {
                Group {
                    MainAttributesView(
                        store: self.store.scope(
                            state: \.mainAttributesState,
                            action: Tabs.Action.mainAttributes
                        )
                    )
                    .tabItem {
                        Image.baseTabBar
                        Text(L10n.tabsBasic)
                    }
                    .tag(0)
                    Text("Fight")
                        .tabItem {
                            Image.fightTabBar
                            Text(L10n.tabsFight)
                        }
                        .tag(1)
                    Text("Skills")
                        .tabItem {
                            Image.skillsTabBar
                            Text(L10n.tabsSkills)
                        }
                        .tag(2)
                    EquipmentView(
                        store: self.store.scope(
                            state: \.equipmentState,
                            action: Tabs.Action.equipment
                        )
                    )
                    .tabItem {
                        Image.equipmentTabBar
                        Text(L10n.tabsEquipment)
                    }
                    .tag(3)
                    OptionsView(
                        store: self.store.scope(
                            state: \.miscState,
                            action: Tabs.Action.misc
                        )
                    )
                    .tabItem {
                        Image.optionsTabBar
                        Text(L10n.tabsMore)
                    }
                    .tag(4)
                }
                .toolbar(.visible, for: .tabBar)
                .toolbarBackground(
                    Color.appBlackDark,
                    for: .tabBar
                )
            }
            .accentColor(.appLightPurple)
        }
    }
}

struct WorkspaceView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView(
            store: Store(
                initialState: .init(character: .mock),
                reducer: Tabs()
            )
        )
    }
}
