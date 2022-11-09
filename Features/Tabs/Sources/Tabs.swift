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

	public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {}
}
