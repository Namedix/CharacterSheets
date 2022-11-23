import ComposableArchitecture
import CommonUI
import Common

public struct Skills: ReducerProtocol {
    
    // MARK: - Properties
    
    public struct State: Equatable {
        // MARK: - Properties
        var skills: [Skill]
        var filteredSkillsIds: [Int] = []
        var isFilteringSkills: Bool = false
        var searchQuery: String = ""
        var isLearningModalPresented: Bool = false
        
        var filteredSkills: [Skill] {
            if filteredSkillsIds.isEmpty {
                return skills
            }
            return skills.filter { filteredSkillsIds.contains($0.id) }
        }
        
        // MARK: - Init
        public init(skills: [Skill]) {
            self.skills = skills
            //            self.filteredSkills = skills
        }
    }
    public enum Action: Equatable {
        case didUseAbility(Skill)
        case didStartUpgrade(Skill)
        case didLowerSkill(Skill)
        case didRaiseSkill(Skill)
        case didFinishUpgrade(Skill)
        case didFilterUsedSkills
        case didFillSearchInput(String)
        case didClearSearch
        case didLearnNewSkill
    }
    
    // MARK: - Initialization
    
    public init() {}
    
    // MARK: - Composable Architecture
    
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .didUseAbility(let skill):
            if let firstIndex = state.skills.firstIndex(of: skill), !skill.isUpgrading {
                state.skills[firstIndex].didUse.toggle()
            }
            return .none
        case .didStartUpgrade(let skill):
            if let firstIndex = state.skills.firstIndex(of: skill), skill.didUse  {
                state.skills[firstIndex].isUpgrading = true
            }
            return .none
        case .didLowerSkill(let skill):
            if let firstIndex = state.skills.firstIndex(of: skill) {
                state.skills[firstIndex].defaultValue -= 1
            }
            return .none
        case .didRaiseSkill(let skill):
            if let firstIndex = state.skills.firstIndex(of: skill) {
                state.skills[firstIndex].defaultValue += 1
            }
            return .none
        case .didFinishUpgrade(let skill):
            if let firstIndex = state.skills.firstIndex(of: skill), skill.didUse  {
                state.skills[firstIndex].didUse = false
                state.skills[firstIndex].isUpgrading = false
            }
            return .none
        case .didFilterUsedSkills:
            state.isFilteringSkills.toggle()
            if state.isFilteringSkills {
                state.filteredSkillsIds = state.skills.filter { $0.didUse }.map(\.id)
            } else {
                state.filteredSkillsIds = []
            }
            return .none
        case .didFillSearchInput(let input):
            state.searchQuery = input
            if input.count < 3 {
                state.filteredSkillsIds = []
            } else {
                state.filteredSkillsIds = state.skills.filter { L10n.localizedString($0.localizedKey).lowercased().contains(input.lowercased()) }.map(\.id)
                if state.filteredSkillsIds.isEmpty {
                    state.filteredSkillsIds = [-1]
                }
            }
            return .none
        case .didClearSearch:
            state.searchQuery = ""
            state.filteredSkillsIds = []
            return .none
        case .didLearnNewSkill:
            state.isLearningModalPresented.toggle()
            return .none
        }
    }
}
