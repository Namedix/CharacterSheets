import Common
import ComposableArchitecture
import Options
import Skills

public struct Tabs: ReducerProtocol {
    // MARK: - Properties

    public struct State: Equatable {
        var character: CthulhuCharacter
        var miscState = Options.State()
        var skillsState = Skills.State(skills: Skill.cotcSkillListData.filter { $0.isLearned })

        public init(character: CthulhuCharacter) {
            self.character = character
        }
    }

    public enum Action: Equatable {
        case misc(Options.Action)
        case skills(Skills.Action)
    }

    // MARK: - Initialization

    public init() {}

    // MARK: - Composable Architecture

    public var body: some ReducerProtocol<State, Action> {
        Scope(state: \.miscState, action: /Action.misc) {
            Options()
        }
        Scope(state: \.skillsState, action: /Action.skills) {
            Skills()
        }
    }
}
