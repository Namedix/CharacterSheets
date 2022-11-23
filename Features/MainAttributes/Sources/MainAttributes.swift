import Common
import ComposableArchitecture

public struct MainAttributes: ReducerProtocol {

	// MARK: - Properties

    public struct State: Equatable {
        var character: CthulhuCharacter

		public init(character: CthulhuCharacter) {
            self.character = character
        }
	}
	public enum Action: Equatable  {}

	// MARK: - Initialization

	public init() {}

	// MARK: - Composable Architecture

	public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {}
}
