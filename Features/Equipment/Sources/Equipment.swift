import ComposableArchitecture
import Common
import Foundation

public struct Equipment: ReducerProtocol {

	// MARK: - Properties

	public struct State: Equatable {
		var items: [Item]
		var wealth: Wealth
		var flippedId: UUID?
		var confirmationDialogState: ConfirmationDialogState<Action>?

		public init(items: [Item], wealth: Wealth) {
			self.items = items
			self.wealth = wealth
		}
	}
	public enum Action: Equatable {
		case tapOnItem(Item)
		case addOneToItem(Item)
		case removeOneFromItem(Item)
		case itemLongPressed(Item)
		case removeItem(Item)
		case flipItems
		case changeWealthTypePressed
		case changeWealthType(WealthLevel)
		case dismissDialog
		case tapOnCash(Cash)
		case addOneToCash(Cash)
		case removeOneFromCash(Cash)
	}

	// MARK: - Initialization

	public init() {}

	// MARK: - Composable Architecture

	public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
		switch action {
		case .tapOnItem(let item):
			state.flippedId = nil
			guard item.stackableDetails != nil else { return .none }
			state.flippedId = item.id
			return .none
		case .addOneToItem(let item):
			if let index = state.items.firstIndex(where: { $0.id == item.id }) {
				state.items[index].stackableDetails?.count += 1
			}
			return .none
		case .removeOneFromItem(let item):
			if let index = state.items.firstIndex(where: { $0.id == item.id }) {
				state.items[index].stackableDetails?.count -= 1

			}
			return .none
		case .itemLongPressed(let item):
			state.confirmationDialogState = .init(
				title: .init(""),
				message: .init("What do you want to do with this item?"),
				buttons: [
					.destructive(.init("Delete"), action: .send(.removeItem(item), animation: .default))
				]
			)
			return .none

		case .removeItem(let item):
			state.items.removeAll(where: { $0.id == item.id })
			return .none

		case .dismissDialog:
			state.confirmationDialogState = nil
			return .none

		case .flipItems:
			state.flippedId = nil
			return .none

		case .changeWealthTypePressed:
			let buttons = WealthLevel.allCases.map { wealthLevel in
				return  AlertState<Action>.Button.default(
					.init(
						wealthLevel.displayName + " (\(wealthLevel.spendingLevel)$)"),
					action: .send(.changeWealthType(wealthLevel), animation: .default)
				)
			}
			state.confirmationDialogState = .init(
				title: .init(""),
				message: .init("New wealth type:"),
				buttons: buttons
			)
			return .none
		case .changeWealthType(let wealthLevel):
			state.wealth.wealthLevel = wealthLevel
			return .none

		case .tapOnCash(let cash):
			state.flippedId = cash.id
			return .none
		case .addOneToCash(let cash):
			if let index = state.wealth.cashes.firstIndex(of: cash) {
				state.wealth.cashes[index].value += 1
			}
			return .none

		case .removeOneFromCash(let cash):
			if let index = state.wealth.cashes.firstIndex(of: cash) {
				state.wealth.cashes[index].value -= 1
			}
			return .none
		}
	}
}
