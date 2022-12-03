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
                                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [4, 1]))
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(skill.didUse ? Color.appLightPurple : Color.appGrey)
                                    .background(
                                        AppCircleView(didUse: skill.didUse)
                                    )
                                    .frame(width: 30, alignment: .center)
                                Spacer()
                                Text(L10n.localizedString(skill.localizedKey))
                                    .multilineTextAlignment(.center)
                                    .textStyle(.whiteSmallRegular)
                                    .fullWidth()
                                    .padding(.all, Margin.small)
                                Spacer()
                                Text("\(skill.defaultValue)")
                                    .textStyle(.whiteSmallRegular)
                                    .frame(width: 42, alignment: .center)
                                    .padding(.vertical, Margin.small)
                                    .background(Color.appLightDark)
                                    .cornerRadius(CornerRadius.standard, corners: [.topLeft, .bottomLeft])
                                Spacer().frame(width: 1)
                                Text("\(skill.halfValue)")
                                    .textStyle(.whiteSmallRegular)
                                    .frame(width: 42, alignment: .center)
                                    .padding(.vertical, Margin.small)
                                    .background(Color.appLightDark)
                                Spacer().frame(width: 1)
                                Text("\(skill.fifthValue)")
                                    .textStyle(.whiteSmallRegular)
                                    .frame(width: 42, alignment: .center)
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
                                        .frame(width: 30, alignment: .center)
                                    Spacer()
                                    ZStack {
                                        HStack(spacing: 0) {
                                            Button {
                                                withAnimation {
                                                    _ = lowerCallback(skill)
                                                }
                                            } label: {
                                                Text("-")
                                                    .textStyle(.whiteTinyBold)
                                                    .padding(.vertical, 12)
                                                    .padding(.horizontal, 32)
                                                    .background(Color.appLightDark)
                                                    .cornerRadius(CornerRadius.standard, corners: [.topLeft, .bottomLeft])
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                            Button {
                                                withAnimation {
                                                    _ = raiseCallback(skill)
                                                }
                                            } label: {
                                                Text("+")
                                                    .textStyle(.whiteTinyBold)
                                                    .padding(.vertical, 12)
                                                    .padding(.horizontal, 32)
                                                    .background(Color.appLightDark)
                                                    .cornerRadius(CornerRadius.standard, corners: [.topRight, .bottomRight])
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        }
                                        Color.appGrey.frame(width: 1, height: 30)
                                    }
                                    Spacer()
                                    Button {
                                        withAnimation(.spring()) {
                                            _ = confirmCallback(skill)
                                        }
                                    } label: {
                                        Text(L10n.skillsConfirm)
                                            .textStyle(.whiteTinyBold)
                                            .padding(.vertical, 12)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .frame(width: 128, alignment: .center)
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
