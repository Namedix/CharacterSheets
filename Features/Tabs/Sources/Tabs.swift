import ComposableArchitecture
import Common

public struct Tabs: ReducerProtocol {
    // MARK: - Properties

	public struct State: Equatable {
		let character: CthulhuCharacter

        public init(character: CthulhuCharacter) {
			self.character = character
		}
    }

	public enum Action: Equatable {}

    // MARK: - Initialization

	public init() {}

    // MARK: - Composable Architecture

    public func reduce(into _: inout State, action _: Action) -> EffectTask<Action> {}
}
