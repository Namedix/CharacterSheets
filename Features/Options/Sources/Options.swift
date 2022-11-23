import Common
import ComposableArchitecture

public struct Options: ReducerProtocol {
    // MARK: - Properties

    public struct State: Equatable {
        public init() {}
    }

    public enum Action: Equatable {
        case changeCharacter
    }

    // MARK: - Initialization

    public init() {}

    // MARK: - Composable Architecture

    public func reduce(into _: inout State, action _: Action) -> EffectTask<Action> {
        return .none
    }
}
