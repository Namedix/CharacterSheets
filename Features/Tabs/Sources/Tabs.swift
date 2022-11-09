import ComposableArchitecture

public struct Tabs: ReducerProtocol {
    // MARK: - Properties

    public struct State {
        public init() {}
    }

    public enum Action {}

    // MARK: - Initialization

    public init() {}

    // MARK: - Composable Architecture

    public func reduce(into _: inout State, action _: Action) -> EffectTask<Action> {}
}
