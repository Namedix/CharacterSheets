import Common
import ComposableArchitecture
import Foundation

public struct Equipment: ReducerProtocol {
    // MARK: - Properties

    public struct State: Equatable {
        var items: [Item]
        var wealth: Wealth
        var flippedId: UUID?
        var confirmationDialogState: ConfirmationDialogState<Action>?
        var alertState: AlertState<Action>?

        public init(items: [Item], wealth: Wealth) {
            self.items = items
            self.wealth = wealth
        }
    }

    public enum Action: Equatable {
        case tapOnItem(Item)
        case addToItem(Int, Item)
        case removeFromItem(Int, Item)
        case itemLongPressed(Item)
        case removeItem(Item)
        case flipItems
        case changeWealthTypePressed
        case changeWealthType(WealthLevel)
        case dismissDialog
        case dismissAlert
        case tapOnCash(Cash)
        case addOneToCash(Cash)
        case removeOneFromCash(Cash)
    }

    // MARK: - Initialization

    public init() {}

    // MARK: - Composable Architecture

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case let .tapOnItem(item):
            state.flippedId = nil
            guard item.stackableDetails != nil else { return .none }
            state.flippedId = item.id
            return .none
        case let .addToItem(count, item):
            if let index = state.items.firstIndex(where: { $0.id == item.id }) {
                state.items[index].stackableDetails?.count += count
            }
            return .none
        case let .removeFromItem(count, item):
            if let index = state.items.firstIndex(where: { $0.id == item.id }) {
                state.items[index].stackableDetails?.count -= count
                if (state.items[index].stackableDetails?.count ?? 0) <= 0 {
                    state.items[index].stackableDetails?.count = 0
                    state.alertState = .init(
                        title: .init("Atention"),
                        message: .init("Count is equal to 0, do you want to remove this item?"),
                        buttons: [
                            .default(.init("Yes"), action: .send(.removeItem(item), animation: .default)),
                            .cancel(.init("No"))
                        ]
                    )
                }
            }
            return .none
        case let .itemLongPressed(item):
            var buttons: [AlertState<Action>.Button] = [
                .destructive(.init("Delete"), action: .send(.removeItem(item), animation: .default)),
            ]
            if item.stackableDetails != nil {
                buttons.insert(
                    contentsOf: [
                        .default(.init("Add 25 to \(item.name)"), action: .send(.addToItem(25, item))),
                        .default(.init("Remove 25 from \(item.name)"), action: .send(.removeFromItem(25, item)))
                    ],
                    at: 0
                )
            }
            state.confirmationDialogState = .init(
                title: .init(""),
                message: .init("What do you want to do with this item?"),
                buttons: buttons
            )
            return .none

        case let .removeItem(item):
            state.items.removeAll(where: { $0.id == item.id })
            return .none

        case .dismissDialog:
            state.confirmationDialogState = nil
            return .none

        case .dismissAlert:
            state.alertState = nil
            return .none

        case .flipItems:
            state.flippedId = nil
            return .none

        case .changeWealthTypePressed:
            let buttons = WealthLevel.allCases.map { wealthLevel in
                AlertState<Action>.Button.default(
                    .init(
                        wealthLevel.displayName + " (\(wealthLevel.spendingLevel)$)"),
                    action: .send(.changeWealthType(wealthLevel))
                )
            }
            state.confirmationDialogState = .init(
                title: .init(""),
                message: .init("New wealth type:"),
                buttons: buttons
            )
            return .none

        case let .changeWealthType(wealthLevel):
            state.wealth.wealthLevel = wealthLevel
            return .none

        case let .tapOnCash(cash):
            state.flippedId = cash.id
            return .none

        case let .addOneToCash(cash):
            if let index = state.wealth.cashes.firstIndex(of: cash) {
                state.wealth.cashes[index].value += 1
            }
            return .none

        case let .removeOneFromCash(cash):
            if let index = state.wealth.cashes.firstIndex(of: cash) {
                state.wealth.cashes[index].value -= 1
            }
            return .none
        }
    }
}
