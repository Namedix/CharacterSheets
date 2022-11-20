import SwiftUI
import Equipment
import Common

@main
struct EquipmentApp: App {
    var body: some Scene {
        WindowGroup {
            EquipmentView(
				store: .init(
					initialState: Equipment.State(
						items: [
							Item(name: "FN fal karabin samoczynno-samopowtarzalny", category: .ammo),
							Item(name: "Pistolet skałkowy", category: .ammo),
							Item(name: "Aspiryna", category: .medicine, stackableDetails: .init(count: 12, unit: "sztuk")),
							Item(name: "Garnitur z wełny czesankowej", category: .manClothes),
							Item(name: "Maszyna do pisania typu Haris", category: .misc),
							Item(name: "Spirytus", category: .medicine, stackableDetails: .init(count: 2, unit: "litry")),
							Item(name: "10 tomowa encyklopedia", category: .misc),
							Item(name: "Loftki kaliber 10", category: .ammo, stackableDetails: .init(count: 25, unit: "sztuk"))
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
}
