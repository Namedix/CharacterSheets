import Common
import ComposableArchitecture
import Equipment
import Options

public struct Tabs: ReducerProtocol {
    // MARK: - Properties

    public struct State: Equatable {
        var character: CthulhuCharacter
        var equipmentState: Equipment.State
        var miscState: Options.State

        public init(character: CthulhuCharacter) {
            self.character = character
            equipmentState = .init(items: character.equipment, wealth: character.wealth)
            miscState = .init()
        }
    }

    public enum Action: Equatable {
        case equipment(Equipment.Action)
        case misc(Options.Action)
    }

    // MARK: - Initialization

    public init() {}

    // MARK: - Composable Architecture

    public var body: some ReducerProtocol<State, Action> {
        Scope(state: \.equipmentState, action: /Action.equipment) {
            Equipment()
        }
        Scope(state: \.miscState, action: /Action.misc) {
            Options()
        }
    }
}
