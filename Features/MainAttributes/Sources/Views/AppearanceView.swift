import SwiftUI
import Common
import CommonUI

struct AppearanceView: View {
    let characterImageName: String
    let address: String
    let birthAddress: String
    let age: Int
    let sex: CharacterSex
    let description: String
    let changeAvatarAction: () -> Void

    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 0) {
                Image(characterImageName, bundle: CommonUIResources.bundle)
                    .padding(.horizontal, Margin.large)
                    .padding(.vertical, Margin.big)
                    .defaultLightCard()
                    .overlay(overlayButton)
                    .fullWidth()
                VStack {
                    CharacteristicTileView(
                        image: .newspaper,
                        title: "Adres zamieszkania",
                        description: address
                    )
                    CharacteristicTileView(
                        image: .newspaper,
                        title: "Adres urodzenia",
                        description: birthAddress
                    )
                    LazyVGrid(
                        columns: [GridItem(.flexible()), GridItem(.flexible())],
                        alignment: .center,
                        spacing: Margin.small
                    ) {
                        CharacteristicTileView(
                            image: .newspaper,
                            title: L10n.commonAge,
                            description: L10n.commonAgeDescription(age)
                        )
                        CharacteristicTileView(
                            image: .newspaper,
                            title: L10n.commonSex,
                            description: sex == .male ? L10n.commonSexMale : L10n.commonSexFemale
                        )
                    }
                    Text(description)
                        .textStyle(.greyTinyRegular)
                        .lineLimit(3)
                        .multilineTextAlignment(.center)
                }.fullWidth()
                Spacer()
            }
            .padding(.vertical, Margin.medium)
            .padding(.trailing, Margin.medium)
            .defaultCard()
        }
        .background(Color.appBlackDark)
    }

    private var overlayButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: changeAvatarAction, label: {
                    Image.settingsKnobs
                        .padding([.bottom, .trailing], Margin.small)
                }).buttonStyle(PlainButtonStyle())
            }
        }
    }
}

#if DEBUG
struct AppearanceModuleView_Previews: PreviewProvider {
    static var previews: some View {
        AppearanceView(
            characterImageName: "test",
            address: "test",
            birthAddress: "Test",
            age: 21,
            sex: .male,
            description: "test",
            changeAvatarAction: {}
        )
    }
}
#endif
