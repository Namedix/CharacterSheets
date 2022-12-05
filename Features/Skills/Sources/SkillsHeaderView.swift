import CommonUI
import SwiftUI

public struct SkillsHeaderView: View {
    public init() {}

    public var body: some View {
        HStack(spacing: 0) {
            Text(L10n.skillsUsed)
                .textStyle(.greyMicroMedium)
                .frame(width: Constants.small, alignment: .center)
            Spacer()
            Text(L10n.skillsSkill)
                .textStyle(.greyMicroMedium)
            Spacer()
            Text(L10n.skillsValue)
                .textStyle(.greyMicroMedium)
                .frame(width: Constants.big, alignment: .center)
            Spacer().frame(width: Sizes.divider)
            Text(L10n.skillsHalf)
                .textStyle(.greyMicroMedium)
                .frame(width: Constants.big, alignment: .center)
            Spacer().frame(width: Sizes.divider)
            Text(L10n.skillsFifth)
                .textStyle(.greyMicroMedium)
                .frame(width: Constants.big, alignment: .center)
        }
        .padding(.bottom, Margin.small)
        .background(color: .appBlackDark)
    }
}

extension SkillsHeaderView {
    enum Constants {
        static let small: CGFloat = 30
        static let big: CGFloat = 42
    }
}

struct SkillsHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SkillsHeaderView()
    }
}
