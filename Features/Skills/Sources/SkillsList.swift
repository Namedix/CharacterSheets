import Common
import CommonUI
import SwiftUI

public struct SkillsList: View {
    let skills: [Skill]
    let callback: (Skill) -> Void
    let longCallback: (Skill) -> Void
    let lowerCallback: (Skill) -> Void
    let raiseCallback: (Skill) -> Void
    let confirmCallback: (Skill) -> Void

    public var body: some View {
        VStack {
            LazyVStack(pinnedViews: [.sectionHeaders]) {
                Section {
                    ForEach(skills) { skill in
                        VStack(spacing: 0) {
                            HStack(spacing: 0) {
                                Circle()
                                    .stroke(style: .regularStroke)
                                    .frame(width: Sizes.small, height: Sizes.small)
                                    .foregroundColor(skill.didUse ? .appLightPurple : .appGrey)
                                    .background(
                                        AppCircleView(didUse: skill.didUse)
                                    )
                                    .frame(width: Constants.small, alignment: .center)
                                Spacer()
                                Text(L10n.localizedString(skill.localizedKey))
                                    .multilineTextAlignment(.center)
                                    .textStyle(.whiteSmallRegular)
                                    .fullWidth()
                                    .padding(.all, Margin.small)
                                Spacer()
                                Text("\(skill.defaultValue)")
                                    .textStyle(.whiteSmallRegular)
                                    .frame(width: Constants.big, alignment: .center)
                                    .padding(.vertical, Margin.small)
                                    .background(Color.appLightDark)
                                    .cornerRadius(CornerRadius.standard, corners: [.topLeft, .bottomLeft])
                                Spacer().frame(width: Sizes.divider)
                                Text("\(skill.halfValue)")
                                    .textStyle(.whiteSmallRegular)
                                    .frame(width: Constants.big, alignment: .center)
                                    .padding(.vertical, Margin.small)
                                    .background(Color.appLightDark)
                                Spacer().frame(width: Sizes.divider)
                                Text("\(skill.fifthValue)")
                                    .textStyle(.whiteSmallRegular)
                                    .frame(width: Constants.big, alignment: .center)
                                    .padding(.vertical, Margin.small)
                                    .background(Color.appLightDark)
                                    .cornerRadius(CornerRadius.standard, corners: [.topRight, .bottomRight])
                            }
                            .padding(.vertical, Margin.micro)
                            .onTapGesture {
                                callback(skill)
                            }
                            .onLongPressGesture {
                                withAnimation(.spring()) {
                                    _ = longCallback(skill)
                                }
                            }
                            if skill.isUpgrading {
                                HStack {
                                    Image.upgradeSkill
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: Constants.small, alignment: .center)
                                    Spacer()
                                    MinusPlusRowView(
                                        voidMinusCallback: {
                                            _ = lowerCallback(skill)
                                        },
                                        voidPlusCallback: {
                                            _ = raiseCallback(skill)
                                        }
                                    )
                                    Spacer()
                                    Button {
                                        withAnimation(.spring()) {
                                            _ = confirmCallback(skill)
                                        }
                                    } label: {
                                        Text(L10n.skillsConfirm)
                                            .textStyle(.whiteTinyBold)
                                            .padding(.vertical, Margin.medium)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .frame(width: Constants.huge, alignment: .center)
                                    .defaultLightCard()
                                }
                                .padding(.top, Margin.small)
                            }
                        }
                    }
                } header: {
                    SkillsHeaderView()
                }
            }
        }
    }
}

extension SkillsList {
    enum Constants {
        static let small: CGFloat = 30
        static let big: CGFloat = 42
        static let huge: CGFloat = 128
    }
}
