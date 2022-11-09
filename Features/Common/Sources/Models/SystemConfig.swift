struct SystemConfig {
    let firstTab: [Modules]
    let secondTab: [Modules]
    let thirdTab: [Modules]
    let fourthTab: [Modules]
    let fifthTab: [Modules]
}

enum Modules: Int {
    case basicInfo
    case appearance
    case characteristics
    case characterHistory
    case health
    case actionTooltip
    case combatStats
    case equipment
    case magicStats
    case spells
    case abilities
    case inventory
    case cash
    case personalAssets
    case notes
    case rules
    case dices
    case systemOwner
}

extension SystemConfig {
    var cthulhu: Self {
        Self(
            firstTab: [Modules.basicInfo, Modules.appearance, Modules.characteristics, Modules.characterHistory],
            secondTab: [Modules.health, Modules.actionTooltip, Modules.combatStats, Modules.equipment, Modules.magicStats, Modules.spells],
            thirdTab: [Modules.abilities],
            fourthTab: [Modules.inventory, Modules.cash, Modules.personalAssets],
            fifthTab: [Modules.notes, Modules.rules, Modules.dices, Modules.systemOwner]
        )
    }
}
