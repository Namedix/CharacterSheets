import Common
import ComposableArchitecture
import Options

public struct Tabs: ReducerProtocol {
    // MARK: - Properties

    public struct State: Equatable {
        var character: CthulhuCharacter
        var miscState = Options.State()

        public init(character: CthulhuCharacter) {
            self.character = character
        }
    }

    public enum Action: Equatable {
        case misc(Options.Action)
    }

    // MARK: - Initialization

    public init() {}

    // MARK: - Composable Architecture

    public var body: some ReducerProtocol<State, Action> {
        Scope(state: \.miscState, action: /Action.misc) {
            Options()
        }
    }
}
