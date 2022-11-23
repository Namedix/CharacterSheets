import Foundation

public struct Skill: Equatable, Identifiable {
    public var id: Int
    public let localizedKey: String
    public let ofChoice: String
    public var didUse: Bool = false
    public let isRare: Bool
    public let isSpecialization: Bool
    public let isModernTimes: Bool
    public let isCalculated: Bool
    public var isUpgrading: Bool = false
    public var defaultValue: Int
    public var isLearned: Bool = false
    public var halfValue: Int {
        defaultValue / 2
    }
    
    public var fifthValue: Int {
        defaultValue / 5
    }
    
    public init (
        id: Int,
        localizedKey: String,
        ofChoice: String = "",
        didUse: Bool = false,
        isRare: Bool = false,
        isSpecialization: Bool = false,
        isModernTimes: Bool = false,
        isCalculated: Bool = false,
        isUpgrading: Bool = false,
        defaultValue: Int,
        isLearned: Bool = false
    ) {
        self.id = id
        self.localizedKey = localizedKey
        self.ofChoice = ofChoice
        self.didUse = didUse
        self.isRare = isRare
        self.isSpecialization = isSpecialization
        self.isModernTimes = isModernTimes
        self.isCalculated = isCalculated
        self.isUpgrading = isUpgrading
        self.defaultValue = defaultValue
        self.isLearned = isLearned || (isRare == false && isSpecialization == false)
    }
}

public extension Skill {
    static var cotcSkillListData: [Skill] {
        [
            .init(id: 0, localizedKey: "Skill_acting", isSpecialization: true, defaultValue: 5),
            .init(id: 1, localizedKey: "Skill_anthropology", defaultValue: 1),
            .init(id: 2, localizedKey: "Skill_archeology", defaultValue: 1),
            .init(id: 3, localizedKey: "Skill_astronomy", isSpecialization: true, defaultValue: 1),
            .init(id: 4, localizedKey: "Skill_whip", isSpecialization: true, defaultValue: 5),
            .init(id: 5, localizedKey: "Skill_brawl", isSpecialization: true, defaultValue: 25, isLearned: true),
            .init(id: 6, localizedKey: "Skill_biology", isSpecialization: true, defaultValue: 1),
            .init(id: 7, localizedKey: "Skill_botany", isSpecialization: true, defaultValue: 1),
            .init(id: 8, localizedKey: "Skill_artillery", isRare: true, defaultValue: 1),
            .init(id: 9, localizedKey: "Skill_heavy_weapons", isSpecialization: true, defaultValue: 10),
            .init(id: 10, localizedKey: "Skill_handgun", isSpecialization: true, defaultValue: 20),
            .init(id: 11, localizedKey: "Skill_flail", isSpecialization: true, defaultValue: 10),
            .init(id: 12, localizedKey: "Skill_disguise", defaultValue: 5),
            .init(id: 13, localizedKey: "Skill_chemistry", isSpecialization: true, defaultValue: 1),
            .init(id: 14, localizedKey: "Skill_read_lips", isRare: true, defaultValue: 1),
            .init(id: 15, localizedKey: "Skill_electronics", isModernTimes: true, defaultValue: 1),
            .init(id: 16, localizedKey: "Skill_electrical_repair", defaultValue: 10),
            .init(id: 17, localizedKey: "Skill_forgery",isSpecialization: true, defaultValue: 5),
            .init(id: 18, localizedKey: "Skill_pharmacy", isSpecialization: true, defaultValue: 1),
            .init(id: 19, localizedKey: "Skill_physics", isSpecialization: true, defaultValue: 1),
            .init(id: 20, localizedKey: "Skill_photography", isSpecialization: true, defaultValue: 5),
            .init(id: 21, localizedKey: "Skill_fast_talk", defaultValue: 5),
            .init(id: 22, localizedKey: "Skill_garotte", isSpecialization: true, defaultValue: 15),
            .init(id: 23, localizedKey: "Skill_geology", isSpecialization: true, defaultValue: 1),
            .init(id: 24, localizedKey: "Skill_hypnosis", isRare: true, defaultValue: 1),
            .init(id: 25, localizedKey: "Skill_history", defaultValue: 5),
            .init(id: 26, localizedKey: "Skill_engineering", isSpecialization: true, defaultValue: 1),
            .init(id: 27, localizedKey: "Skill_ride", defaultValue: 5),
            .init(id: 28, localizedKey: "Skill_lang_foreign", isSpecialization: true, defaultValue: 1),
            .init(id: 29, localizedKey: "Skill_lang_own", isCalculated: true, defaultValue: -1),
            .init(id: 30, localizedKey: "Skill_rifle_shotgun", isSpecialization: true, defaultValue: 25),
            .init(id: 31, localizedKey: "Skill_machine_gun", isSpecialization: true, defaultValue: 10),
            .init(id: 32, localizedKey: "Skill_library_use", defaultValue: 20),
            .init(id: 33, localizedKey: "Skill_computer_use", isModernTimes: true, defaultValue: 5),
            .init(id: 34, localizedKey: "Skill_forensics", isSpecialization: true, defaultValue: 1),
            .init(id: 35, localizedKey: "Skill_cryptography", isSpecialization: true, defaultValue: 1),
            .init(id: 36, localizedKey: "Skill_accounting", defaultValue: 5),
            .init(id: 37, localizedKey: "Skill_bow", isSpecialization: true, defaultValue: 15),
            .init(id: 38, localizedKey: "Skill_mathematics", isSpecialization: true, defaultValue: 10),
            .init(id: 39, localizedKey: "Skill_demolitions", isRare: true, defaultValue: 1),
            .init(id: 40, localizedKey: "Skill_mechanical_repair", defaultValue: 10),
            .init(id: 41, localizedKey: "Skill_medicine", defaultValue: 1),
            .init(id: 42, localizedKey: "Skill_meteorology", isSpecialization: true, defaultValue: 1),
            .init(id: 43, localizedKey: "Skill_sword", isSpecialization: true, defaultValue: 20),
            .init(id: 44, localizedKey: "Skill_flamethrower", isSpecialization: true, defaultValue: 10),
            .init(id: 45, localizedKey: "Skill_cthulhu_mythos", defaultValue: 0),
            .init(id: 46, localizedKey: "Skill_listen", defaultValue: 20),
            .init(id: 47, localizedKey: "Skill_navigate", defaultValue: 10),
            .init(id: 48, localizedKey: "Skill_diving", isRare: true, defaultValue: 1),
            .init(id: 49, localizedKey: "Skill_operating_heavy_machinery", defaultValue: 1),
            .init(id: 50, localizedKey: "Skill_occult", defaultValue: 5),
            .init(id: 51, localizedKey: "Skill_persuade", defaultValue: 10),
            .init(id: 52, localizedKey: "Skill_first_aid", defaultValue: 30),
            .init(id: 53, localizedKey: "Skill_chainsaw", isSpecialization: true, defaultValue: 10),
            .init(id: 54, localizedKey: "Skill_submachine_gun", isSpecialization: true, defaultValue: 15),
            .init(id: 55, localizedKey: "Skill_swim", defaultValue: 20),
            .init(id: 56, localizedKey: "Skill_law", defaultValue: 5),
            .init(id: 57, localizedKey: "Skill_drive_auto", defaultValue: 20),
            .init(id: 58, localizedKey: "Skill_psychoanalysis", defaultValue: 1),
            .init(id: 59, localizedKey: "Skill_psychology", defaultValue: 10),
            .init(id: 60, localizedKey: "Skill_throw", defaultValue: 20),
            .init(id: 61, localizedKey: "Skill_jump", defaultValue: 20),
            .init(id: 62, localizedKey: "Skill_spot_hidden", defaultValue: 25),
            .init(id: 63, localizedKey: "Skill_survival", isRare: true, defaultValue: 10),
            .init(id: 64, localizedKey: "Skill_fine_art", isSpecialization: true, defaultValue: 5),
            .init(id: 65, localizedKey: "Skill_locksmith", defaultValue: 1),
            .init(id: 66, localizedKey: "Skill_axe", isSpecialization: true, defaultValue: 15),
            .init(id: 67, localizedKey: "Skill_animal_handling", isRare: true, defaultValue: 5),
            .init(id: 68, localizedKey: "Skill_track", defaultValue: 10),
            .init(id: 69, localizedKey: "Skill_stealth", defaultValue: 20),
            .init(id: 70, localizedKey: "Skill_dodge", isCalculated: true, defaultValue: -1),
            .init(id: 71, localizedKey: "Skill_charm", defaultValue: 15),
            .init(id: 72, localizedKey: "Skill_natural_world", defaultValue: 10),
            .init(id: 73, localizedKey: "Skill_spear", isSpecialization: true, defaultValue: 20),
            .init(id: 74, localizedKey: "Skill_climb", defaultValue: 20),
            .init(id: 75, localizedKey: "Skill_appraise", defaultValue: 5),
            .init(id: 76, localizedKey: "Skill_intimidate", defaultValue: 15),
            .init(id: 77, localizedKey: "Skill_zoology", isSpecialization: true, defaultValue: 1),
            .init(id: 78, localizedKey: "Skill_sleight_of_hand", defaultValue: 10)
        ]
    }
}
