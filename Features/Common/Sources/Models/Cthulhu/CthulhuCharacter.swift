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

public enum ItemType: String, Equatable {
    case manClothes
    case womanClothes
    case food
    case drink
    case travelingEquipment
    case meeleWeapon
    case rangeWeapon
    case throwingWeapon
    case misc
}

public class Item: Equatable {
    public let name: String
    public let type: ItemType

    public init(name: String, type: ItemType) {
        self.name = name
        self.type = type
    }

    public static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.name == rhs.name && lhs.type == rhs.type
    }
}

public class Weapon: Item {
    public let value: Int
    public let damage: String
    public let range: Int?
    public let minAttacks: Int?
    public let maxAttacks: Int?
    public let ammo: Int?
    public let malfunction: Int?

    public var halfValue: Int {
        value / 2
    }

    public var fifthValue: Int {
        value / 5
    }

    init(
        name: String,
        type: ItemType,
        value: Int,
        damage: String,
        range: Int?,
        minAttacks: Int?,
        maxAttacks: Int?,
        ammo: Int?,
        malfunction: Int?
    ) {
        self.value = value
        self.damage = damage
        self.range = range
        self.minAttacks = minAttacks
        self.maxAttacks = maxAttacks
        self.ammo = ammo
        self.malfunction = malfunction
        super.init(name: name, type: type)
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

public struct Wealth: Equatable {
    public var wealth: Int
    public var cash: Int
    public var assets: String
    public var currency: String
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
                Weapon(
                    name: "Brawl",
                    type: .meeleWeapon,
                    value: 25,
                    damage: "1k3 + MO",
                    range: nil,
                    minAttacks: 1,
                    maxAttacks: 1,
                    ammo: nil,
                    malfunction: nil
                ),
                .init(name: "Pencil and notebook", type: .misc),
                .init(name: "Camera", type: .misc),
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
            wealth: .init(wealth: 10, cash: 82, assets: "2050$ Apartment", currency: "$")
        )
    }
}
