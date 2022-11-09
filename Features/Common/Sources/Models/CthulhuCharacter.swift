//
//  CthulhuCharacter.swift
//  Common
//
//  Created by Bartek Pichalski on 06/11/2022.
//  Copyright © 2022 com.rook. All rights reserved.
//

import Foundation

enum CharacterSex {
	case male
	case female
}

struct Age {
	let value: Int

	var modifier: Int {
		switch value {
		case 40...49:
			return 1
		case 50...59:
			return 2
		case 60...69:
			return 3
		case 70...79:
			return 4
		case 80...Int.max:
			return 5
		default:
			return 0
		}
	}
}

struct BasicInfo {
	let name: String
	var occupation: String
	var age: Age
	let sex: CharacterSex
	var adress: String
	let birthPlace: String
	var appearanceImageName: String?
}

struct Characteristics {
	let strenght: Int
	let constitution: Int
	let dexternity: Int
	let inteligence: Int
	let size: Int
	let power: Int
	let apperance: Int
	let education: Int
}

struct Healht {
	var maxValue: Int
	var currentValue: Int
	var criticalWound: Bool = false // changes when you're hit with at least half hp in single blow
	var status: Status = .alive

	enum Status {
		case alive
		case dead // fail CON roll while dying || fall below 0 hp
		case unconscious // hit over half hp and fail CON roll || hit 0
		case dying // hit 0 hp while criticalWound == true
	}
}

struct Sanity {
	let startingValue: Int // starting Power
	var currentValue: Int // sanity adjusted with rolls
	var maxValue: Int // 99 - knowledge of cthulhu mythos
	var temporaryInsanity: Bool = false
	var indefiniteInsanity: Bool = false
	var insanityThreshold: Int {
		startingValue / 5
	}
}

struct UsableValue {
	var maxValue: Int
	var currentValue: Int
}

struct Skill {
	let name: String
	var didUse: Bool = false
	var defaultValue: Int
	var halfValue: Int {
		defaultValue / 2
	}
	var fifthValue: Int {
		defaultValue / 5
	}
}

enum ItemType: String {
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

class Item {
	let name: String
	let type: ItemType

	init(name: String, type: ItemType) {
		self.name = name
		self.type = type
	}
}

class Weapon: Item  {
	let value: Int
	let damage: String
	let range: Int?
	let minAttacks: Int?
	let maxAttacks: Int?
	let ammo: Int?
	let malfunction: Int?

	var halfValue: Int {
		value / 2
	}
	var fifthValue: Int {
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

struct Combat {
	let damageBonus: String
	let build: Int

	init(strenght: Int, constitution: Int) {
		let sum = strenght + constitution
		switch sum {
		case 2...64:
			damageBonus = "-2"
			build = -2
		case 65...84:
			damageBonus = "-1"
			build = -1
		case 85...124:
			damageBonus = "0"
			build = 0
		case 125...164:
			damageBonus = "+1k4"
			build = 1
		case 165...204:
			damageBonus = "+1k6"
			build = 2
		default:
			damageBonus = "999"
			build = 999
		}
	}
}

struct History {
	var personalDescription: String
	var traits: String
	var ideologyBeliefs: String
	var injuriesScars: String
	var significantPeople: String
	var phobiasManias: String
	var meaningfulLocations: String
	var arcaneTomesSpells: String
	var treasuredPossessions: String
	var encountersWithStrangeEntities: String
}

struct Wealth {
	var wealth: Int
	var cash: Int
	var assets: String
	var currency: String
}

struct CthulhuCharacter {
	var inestigatorData: BasicInfo
	var health: Healht
	var sanity: Sanity
	var magicPoints: UsableValue
	var luck: UsableValue
	let characteristics: Characteristics
	var skills: [Skill]
	var equipment: [Item]
	var move: Int {
		if characteristics.strenght < characteristics.constitution && characteristics.dexternity < characteristics.constitution {
			return 7 - inestigatorData.age.modifier
		} else if characteristics.strenght > characteristics.constitution && characteristics.dexternity > characteristics.constitution {
			return 9 - inestigatorData.age.modifier
		} else {
			return 8 - inestigatorData.age.modifier
		}
	}
	var combat: Combat {
		Combat(strenght: characteristics.strenght, constitution: characteristics.constitution)
	}
	var history: History
	var wealth: Wealth
}

extension CthulhuCharacter {
	var mock: Self {
		Self(
			inestigatorData: .init(
				name: "Harvey Wolters",
				occupation: "Journalist",
				age: .init(value: 42),
				sex: .male,
				adress: "Nowy York",
				birthPlace: "Boston",
				appearanceImageName: nil
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
				.init(name: "Camera", type: .misc)
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
