//
//  CthulhuCharacter.swift
//  Common
//
//  Created by Bartek Pichalski on 06/11/2022.
//  Copyright © 2022 com.rook. All rights reserved.
//

import Foundation

public enum CharacterSex: Equatable {
    case male
    case female
}

public struct Age: Equatable {
    public let value: Int

    public var modifier: Int {
        switch value {
        case 40 ... 49:
            return 1
        case 50 ... 59:
            return 2
        case 60 ... 69:
            return 3
        case 70 ... 79:
            return 4
        case 80 ... Int.max:
            return 5
        default:
            return 0
        }
    }
}

public struct Occupation: Equatable {
    public let value: String
    public let imageName: String
}

public struct BasicInfo: Equatable {
    public let name: String
    public var occupation: Occupation
    public var age: Age
    public let sex: CharacterSex
    public var adress: String
    public let birthPlace: String
    public var appearanceImageName: String?
}

public struct Characteristics: Equatable {
    public let strenght: Int
    public let constitution: Int
    public let dexternity: Int
    public let inteligence: Int
    public let size: Int
    public let power: Int
    public let apperance: Int
    public let education: Int
}

public struct Healht: Equatable {
    public var maxValue: Int
    public var currentValue: Int
    public var criticalWound: Bool = false // changes when you're hit with at least half hp in single blow
    public var status: Status = .alive

    public enum Status: Equatable {
        case alive
        case dead // fail CON roll while dying || fall below 0 hp
        case unconscious // hit over half hp and fail CON roll || hit 0
        case dying // hit 0 hp while criticalWound == true
    }
}

public struct Sanity: Equatable {
    public let startingValue: Int // starting Power
    public var currentValue: Int // sanity adjusted with rolls
    public var maxValue: Int // 99 - knowledge of cthulhu mythos
    public var temporaryInsanity: Bool = false
    public var indefiniteInsanity: Bool = false
    public var insanityThreshold: Int {
        startingValue / 5
    }
}

public struct UsableValue: Equatable {
    public var maxValue: Int
    public var currentValue: Int
}

public struct Skill: Equatable {
    public let name: String
    public var didUse: Bool = false
    public var defaultValue: Int
    public var halfValue: Int {
        defaultValue / 2
    }

    public var fifthValue: Int {
        defaultValue / 5
    }
}

public enum ItemCategory: Equatable {
    case manClothes
	case shortRangeWeapon(ItemWeaponDetails)
	case semiAutomaticWeapon(ItemWeaponDetails)
	case medicine
	case ammo
    case misc

	public var displayName: String {
		switch self {
		case .manClothes:
			return "Ubrania męskie"
		case .shortRangeWeapon:
			return "Broń krótka"
		case .semiAutomaticWeapon:
			return "Karabin automatyczny"
		case .medicine:
			return "Środki medyczne"
		case .ammo:
			return "Amunicja"
		case .misc:
			return "Rozmaitości"
		}
	}

	public var imageName: String {
		switch self {
		case .manClothes:
			return "fedora"
		case .shortRangeWeapon:
			return "luger"
		case .semiAutomaticWeapon:
			return "ak47"
		case .medicine:
			return "medicine-pills"
		case .ammo:
			return "machine-gun-magazine"
		case .misc:
			return "backpack"
		}
	}
}

public struct ItemWeaponDetails: Equatable {
	public let value: Int
	public let damage: String
	public let range: Int?
	public let minAttacks: Int?
	public let maxAttacks: Int?
	public let ammo: Int?
	public let malfunction: Int?

	public init(
		value: Int,
		damage: String,
		range: Int? = nil,
		minAttacks: Int? = nil,
		maxAttacks: Int? = nil,
		ammo: Int? = nil,
		malfunction: Int? = nil
	) {
		self.value = value
		self.damage = damage
		self.range = range
		self.minAttacks = minAttacks
		self.maxAttacks = maxAttacks
		self.ammo = ammo
		self.malfunction = malfunction
	}
}

public struct StackableDetails: Equatable {
	public init(count: Int, unit: String) {
		self.count = count
		self.unit = unit
	}

	public var count: Int
	public let unit: String
}

public struct Item: Equatable, Identifiable  {
	public let id: UUID
	public let name: String
	public let category: ItemCategory
	public var stackableDetails: StackableDetails?

	public init(
		id: UUID = .init(),
		name: String,
		category: ItemCategory,
		stackableDetails: StackableDetails? = nil
	) {
		self.id = id
		self.name = name
		self.category = category
		self.stackableDetails = stackableDetails
	}
}

public struct Combat: Equatable {
    public let damageBonus: String
    public let build: Int

    init(strenght: Int, constitution: Int) {
        let sum = strenght + constitution
        switch sum {
        case 2 ... 64:
            damageBonus = "-2"
            build = -2
        case 65 ... 84:
            damageBonus = "-1"
            build = -1
        case 85 ... 124:
            damageBonus = "0"
            build = 0
        case 125 ... 164:
            damageBonus = "+1k4"
            build = 1
        case 165 ... 204:
            damageBonus = "+1k6"
            build = 2
        default:
            damageBonus = "999"
            build = 999
        }
    }
}

public struct History: Equatable {
    public var personalDescription: String
    public var traits: String
    public var ideologyBeliefs: String
    public var injuriesScars: String
    public var significantPeople: String
    public var phobiasManias: String
    public var meaningfulLocations: String
    public var arcaneTomesSpells: String
    public var treasuredPossessions: String
    public var encountersWithStrangeEntities: String
}

public enum WealthLevel: CaseIterable {
	case penniless
	case poor
	case average
	case wealthy
	case rich
	case superRich

	init(value: Int) {
		switch value {
		case 1 ... 9:
			self = .poor
		case 10 ... 49:
			self = .average
		case 50 ... 89:
			self = .wealthy
		case 90 ... 98:
			self = .rich
		case 99 ... Int.max:
			self = .superRich
		default:
			self = .penniless
		}
	}

	public var displayName: String {
		switch self {
		case .penniless:
			return "Penniless"
		case .poor:
			return "Poor"
		case .average:
			return "Average"
		case .wealthy:
			return "Wealthy"
		case .rich:
			return "Rich"
		case .superRich:
			return "Super Rich"
		}
	}

	public var spendingLevel: Double {
		switch self {
		case .penniless:
			return 0.5
		case .poor:
			return 2
		case .average:
			return 10
		case .wealthy:
			return 50
		case .rich:
			return 250
		case .superRich:
			return 5000
		}
	}
}

public struct WealthAsset: Equatable, Hashable {
	public init(name: String, value: Int) {
		self.name = name
		self.value = value
	}

	public var name: String
	public var value: Int
}

public struct Wealth: Equatable {
	public init(wealthLevel: WealthLevel, cashes: [Cash], assets: [WealthAsset]) {
		self.wealthLevel = wealthLevel
		self.cashes = cashes
		self.assets = assets
	}

    public var wealthLevel: WealthLevel
	public var cashes: [Cash]
    public var assets: [WealthAsset]

	public var totalAssetsWealth: Int {
		assets.map(\.value).reduce(0, +)
	}
}

public struct Cash: Equatable, Identifiable {
	public init(currency: String, value: Int, type: CashType) {
		self.currency = currency
		self.value = value
		self.type = type
	}

	public let id: UUID = .init()
	public let currency: String
	public var value: Int
	public let type: CashType

	public enum CashType {
		case bills
		case coins

		public var imageName: String {
			switch self {
			case .coins:
				return "coins"
			case .bills:
				return "money-stack"
			}
		}
	}
}

public struct CthulhuCharacter: Equatable, Identifiable {
    public let id: UUID
    public var inestigatorData: BasicInfo
    public var health: Healht
    public var sanity: Sanity
    public var magicPoints: UsableValue
    public var luck: UsableValue
    public let characteristics: Characteristics
    public var skills: [Skill]
    public var equipment: [Item]
    public var move: Int {
        if characteristics.strenght < characteristics.constitution, characteristics.dexternity < characteristics.constitution {
            return 7 - inestigatorData.age.modifier
        } else if characteristics.strenght > characteristics.constitution, characteristics.dexternity > characteristics.constitution {
            return 9 - inestigatorData.age.modifier
        } else {
            return 8 - inestigatorData.age.modifier
        }
    }

    public var combat: Combat {
        Combat(strenght: characteristics.strenght, constitution: characteristics.constitution)
    }

    public var history: History
    public var wealth: Wealth
}

public extension CthulhuCharacter {
    static var mock: Self {
        Self(
            id: .init(),
            inestigatorData: .init(
                name: "Harvey Wolters",
                occupation: .init(value: "Journalist", imageName: "newspaper"),
                age: .init(value: 42),
                sex: .male,
                adress: "Nowy York",
                birthPlace: "Boston",
                appearanceImageName: "characterReporter"
            ),
            health: .init(maxValue: 15, currentValue: 15),
            sanity: .init(startingValue: 45, currentValue: 45, maxValue: 99),
            magicPoints: .init(maxValue: 9, currentValue: 9),
            luck: .init(maxValue: 45, currentValue: 45),
            characteristics: .init(
                strenght: 20,
                constitution: 70,
                dexternity: 55,
                inteligence: 85,
                size: 80,
                power: 45,
                apperance: 80,
                education: 84
            ),
            skills: [],
            equipment: [
				Item(
					name: "Brawl",
					category: .shortRangeWeapon(
						.init(
							value: 25,
							damage: "1k3 + MO",
							range: nil,
							minAttacks: 1,
							maxAttacks: 1,
							ammo: nil,
							malfunction: nil
						)
					)
				),
				Item(name: "Pencil and notebook", category: .misc),
				Item(name: "Camera", category: .misc),
            ],
            history: .init(
                personalDescription: "Handsome, good looking and with a little bit of overweight.",
                traits: "Ladies man",
                ideologyBeliefs: "Faith in destination. Searching for signs and omens.",
                injuriesScars: "",
                significantPeople: "Uncle Teodore, who teached him lvoe to archeology. Harvey wants to prove that he's better human than his uncle, who got insane with obessions",
                phobiasManias: "",
                meaningfulLocations: "Workshop on upper floor of his apartment",
                arcaneTomesSpells: "",
                treasuredPossessions: "His uncle artifacts reside in Harvey's workshop",
                encountersWithStrangeEntities: ""
            ),
			wealth: .init(
				wealthLevel: .average,
				cashes: [.init(currency: "Dollar", value: 20, type: .bills), .init(currency: "Cent", value: 50, type: .coins)],
				assets: [.init(name: "Samochód", value: 150), .init(name: "Dom", value: 2050)]
			)
        )
    }
}
