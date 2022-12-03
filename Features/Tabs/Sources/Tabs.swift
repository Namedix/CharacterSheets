import Common
import ComposableArchitecture
import Equipment
import Options
import MainAttributes

public struct Tabs: ReducerProtocol {
    // MARK: - Properties

    public struct State: Equatable {
        var character: CthulhuCharacter
        var equipmentState: Equipment.State
        var miscState: Options.State
        var mainAttributesState: MainAttributes.State

        public init(character: CthulhuCharacter) {
            self.character = character
            mainAttributesState = .init(character: character)
            equipmentState = .init(items: character.equipment, wealth: character.wealth)
            miscState = .init()
        }
    }

    public enum Action: Equatable {
        case mainAttributes(MainAttributes.Action)
        case equipment(Equipment.Action)
        case misc(Options.Action)
    }

    // MARK: - Initialization

    public init() {}

    // MARK: - Composable Architecture

    public var body: some ReducerProtocol<State, Action> {
        Scope(state: \.mainAttributesState, action: /Action.mainAttributes) {
            MainAttributes()
        }
        Scope(state: \.equipmentState, action: /Action.equipment) {
            Equipment()
        }
        Scope(state: \.miscState, action: /Action.misc) {
            Options()
        }
    }
}
