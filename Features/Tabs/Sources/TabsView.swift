import CommonUI
import ComposableArchitecture
import Options
import SwiftUI

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
                    Text("Main Attributes")
                        .tabItem {
                            Image.baseTabBar
                            Text("Basic")
                        }
                        .tag(0)
                    Text("Fight")
                        .tabItem {
                            Image.fightTabBar
                            Text("Fighting")
                        }
                        .tag(1)
                    Text("Skills")
                        .tabItem {
                            Image.skillsTabBar
                            Text("Skills")
                        }
                        .tag(2)
                    Text("Equipment")
                        .tabItem {
                            Image.equipmentTabBar
                            Text("Equipment")
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
                        Text("More")
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
