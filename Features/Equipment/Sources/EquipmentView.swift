import Common
import CommonUI
import ComposableArchitecture
import SwiftUI
import SwiftUIMasonry

public struct EquipmentView: View {
    // MARK: - Properties

    var store: StoreOf<Equipment>

    // MARK: - Initialization

    public init(store: StoreOf<Equipment>) {
        self.store = store
    }

    // MARK: - View

    public var body: some View {
        WithViewStore(self.store) { viewStore in
            GeometryReader { _ in
                ScrollView {
                    VStack(spacing: Margin.medium) {
                        SectionHeaderView(title: "Ekwipunek", image: .openTreasureChest)
                        VMasonry(columns: 2, spacing: Margin.medium) {
                            ForEach(viewStore.items) { item in
                                VStack(alignment: .leading, spacing: Margin.small) {
                                    if item.id != viewStore.flippedId {
                                        tileHeader(
                                            with: item.category.displayName,
                                            imageName: item.category.imageName
                                        )
                                        if let stackableDetails = item.stackableDetails {
                                            stackedDescription(
                                                with: item.name,
                                                count: stackableDetails.count,
                                                unit: stackableDetails.unit
                                            )
                                        } else {
                                            normalDescription(with: item.name)
                                        }
                                    } else {
                                        AmountTileView(
                                            value: item.stackableDetails?.count ?? 0,
                                            addAction: { viewStore.send(.addOneToItem(item)) },
                                            reduceAction: { viewStore.send(.removeOneFromItem(item)) }
                                        ).flipAnimation(isFlipped: true)
                                    }
                                }
                                .padding(Margin.medium)
                                .fullWidth()
                                .defaultLightCard()
                                .flipAnimation(isFlipped: item.id == viewStore.flippedId)
                                .onTapGesture {
                                    withAnimation {
                                        _ = viewStore.send(.tapOnItem(item))
                                    }
                                }
                                .onLongPressGesture {
                                    viewStore.send(.itemLongPressed(item))
                                }
                            }
                        }
                        cashHeader(wealthTypeDispalyName: "\(viewStore.wealth.wealthLevel.displayName) (\(String(format: "%g", viewStore.wealth.wealthLevel.spendingLevel))$)") {
                            viewStore.send(.changeWealthTypePressed)
                        }
                        LazyVGrid(
                            columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
                        ) {
                            ForEach(viewStore.wealth.cashes) { cash in
                                CashView(
                                    image: Image(cash.type.imageName, bundle: CommonUIResources.bundle),
                                    value: cash.value,
                                    currency: cash.currency,
                                    isFlipped: viewStore.flippedId != cash.id,
                                    addAction: { viewStore.send(.addOneToCash(cash)) },
                                    reduceAction: { viewStore.send(.removeOneFromCash(cash)) }
                                ).onTapGesture {
                                    withAnimation {
                                        _ = viewStore.send(.tapOnCash(cash))
                                    }
                                }
                            }
                        }
                        Text("Można zmienić status społeczny poprzez kliknięcie na nazwę majętności.")
                            .textStyle(.greyTinyRegular)
                        SectionHeaderView(title: "Dobytek - (\(viewStore.wealth.totalAssetsWealth)$)", image: .openTreasureChest)
                        FlexibleView(
                            data: viewStore.wealth.assets,
                            spacing: Margin.small,
                            alignment: .leading
                        ) { wealth in
                            Text("\(wealth.name) (\(wealth.value)$)")
                                .padding(.all, Margin.medium)
                                .textStyle(.greyRegular)
                                .background(Color.appLightDark)
                                .cornerRadius(CornerRadius.standard)
                                .onTapGesture {}
                        }
                    }
                    .padding(Margin.medium)
                }
            }
            .background(color: .appBlackDark)
            .onTapGesture {
                withAnimation {
                    _ = viewStore.send(.flipItems)
                }
            }
            .confirmationDialog(
                self.store.scope(state: \.confirmationDialogState),
                dismiss: Equipment.Action.dismissDialog
            )
        }
    }

    private func cashHeader(
        wealthTypeDispalyName: String,
        changeWealthTypeAction: @escaping () -> Void
    ) -> some View {
        HStack {
            Text("Gotówka")
                .textStyle(.whiteMediumBold)
                .shadow(
                    color: Color.appWhite.opacity(0.2),
                    radius: 15, x: 0, y: 1
                )
            Spacer()
            Button(action: changeWealthTypeAction) {
                Text(wealthTypeDispalyName)
                    .textStyle(.greyBold)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, Margin.regular)
        .padding(.vertical, Margin.small)
    }

    private func tileHeader(with name: String, imageName: String) -> some View {
        HStack(spacing: Margin.micro) {
            Text(name)
                .fontWeight(.bold)
                .foregroundColor(.appWhite)
                .font(.system(size: 14))
                .multilineTextAlignment(.leading)
            Spacer()
            Image(imageName, bundle: CommonUIResources.bundle)
                .resizable()
                .scaledToFit()
                .frame(width: Sizes.normal, height: Sizes.normal)
        }
    }

    private func stackedDescription(with name: String, count: Int, unit: String) -> some View {
        Group {
            Text(name + ", ")
                .foregroundColor(.appGrey) +
                Text("\(count) \(unit)")
                .foregroundColor(.appWhite)
                .fontWeight(.bold)
        }
        .font(.system(size: 16))
        .multilineTextAlignment(.leading)
    }

    private func normalDescription(with name: String) -> some View {
        Text(name)
            .foregroundColor(.appGrey)
            .font(.system(size: 16))
            .multilineTextAlignment(.leading)
    }
}

#if DEBUG
    struct WorkspaceView_Previews: PreviewProvider {
        static var previews: some View {
            EquipmentView(
                store: Store(
                    initialState: .init(
                        items: [
                            Item(name: "FN fal karabin samoczynno-samopowtarzalny", category: .ammo),
                            Item(name: "Pistolet skałkowy", category: .ammo),
                            Item(name: "Aspiryna", category: .medicine, stackableDetails: .init(count: 12, unit: "sztuk")),
                            Item(name: "Garnitur z wełny czesankowej", category: .manClothes),
                            Item(name: "Maszyna do pisania typu Haris", category: .misc),
                            Item(name: "Spirytus", category: .medicine, stackableDetails: .init(count: 2, unit: "litry")),
                            Item(name: "10 tomowa encyklopedia", category: .misc),
                            Item(name: "Loftki kaliber 10", category: .ammo, stackableDetails: .init(count: 25, unit: "sztuk")),
                        ],
                        wealth: .init(
                            wealthLevel: .average,
                            cashes: [.init(currency: "Dollar", value: 20, type: .bills), .init(currency: "Cent", value: 50, type: .coins)],
                            assets: [.init(name: "Dom", value: 150)]
                        )
                    ),
                    reducer: Equipment()
                )
            )
        }
    }
#endif
