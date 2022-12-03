import Common
import CommonUI
import ComposableArchitecture
import SwiftUI

public struct SkillsView: View {
    // MARK: - Properties

    var store: StoreOf<Skills>

    // MARK: - Initialization

    public init(store: StoreOf<Skills>) {
        self.store = store
    }

    // MARK: - View

    public var body: some View {
        WithViewStore(self.store) { viewStore in
            ScrollView(showsIndicators: false) {
                SectionHeaderView(
                    title: L10n.skillsTitle,
                    image: .filterSkills,
                    rightAction: {
                        withAnimation {
                            _ = viewStore.send(.didFilterUsedSkills)
                        }
                    },
                    // TODO: Add modal to learn skills
                    secondaryImage: .learn
                ) {
                    withAnimation {
                        _ = viewStore.send(.didLearnNewSkill)
                    }
                }
                HStack {
                    Image.search
                    TextField(
                        L10n.skillsSearch,
                        text: .init(
                            get: { viewStore.searchQuery },
                            set: { query in
                                withAnimation {
                                    _ = viewStore.send(.didFillSearchInput(query))
                                }
                            }
                        )
                    )
                    if viewStore.searchQuery != "" {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color.appBlackDark)
                            .onTapGesture {
                                withAnimation {
                                    _ = viewStore.send(.didClearSearch)
                                }
                            }
                    }
                }
                .padding(Margin.small)
                .background(Color.appLightDark)
                .cornerRadius(CornerRadius.standard)
                SkillsList(
                    skills: viewStore.filteredSkills,
                    callback: { skill in
                        viewStore.send(.didUseAbility(skill))
                    },
                    longCallback: { skill in
                        viewStore.send(.didStartUpgrade(skill))
                    },
                    lowerCallback: { skill in
                        viewStore.send(.didLowerSkill(skill))
                    },
                    raiseCallback: { skill in
                        viewStore.send(.didRaiseSkill(skill))
                    },
                    confirmCallback: { skill in
                        viewStore.send(.didFinishUpgrade(skill))
                    }
                )
                .padding(.top, Margin.medium)
                .padding(.trailing, Margin.micro)
                Text(L10n.skillsTooltip)
                    .textStyle(.greyTinyMedium)
                Spacer()
            }
            .padding(.horizontal, Margin.medium)
            .padding(.top, 1)
            .background(color: .appBlackDark)
        }
    }
}

struct WorkspaceView_Previews: PreviewProvider {
    static var previews: some View {
        SkillsView(
            store: Store(
                initialState: .init(skills: Skill.cotcSkillListData.filter { $0.isLearned }),
                reducer: Skills()
            )
        )
    }
}
