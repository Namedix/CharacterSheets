import Common
import Skills
import SwiftUI

@main
struct SkillsApp: App {
    var body: some Scene {
        WindowGroup {
            SkillsView(
                store: .init(initialState: Skills.State(skills: Skill.cotcSkillListData.filter { $0.isLearned }), reducer: Skills())
            )
        }
    }
}
