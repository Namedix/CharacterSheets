import SwiftUI
import CommonUI

public struct SkillsHeaderView: View {
    public init() {}
    
    public var body: some View {
        VStack {
            HStack (spacing: 0) {
                Text(L10n.skillsUsed)
                    .textStyle(.greyMicroMedium)
                    .frame(width: 30, alignment: .center)
                Spacer()
                Text(L10n.skillsSkill)
                    .textStyle(.greyMicroMedium)
                Spacer()
                Text(L10n.skillsValue)
                    .textStyle(.greyMicroMedium)
                    .frame(width: 42, alignment: .center)
                Spacer().frame(width: 1)
                Text(L10n.skillsHalf)
                    .textStyle(.greyMicroMedium)
                    .frame(width: 42, alignment: .center)
                Spacer().frame(width: 1)
                Text(L10n.skillsFifth)
                    .textStyle(.greyMicroMedium)
                    .frame(width: 42, alignment: .center)
            }
        }
    }
}

struct SkillsHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SkillsHeaderView()
    }
}
