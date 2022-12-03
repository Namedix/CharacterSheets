import SwiftUI
import CommonUI

public struct CharacteristicTileView: View {
    let image: Image
    let title: String
    let description: String

    public init(image: Image, title: String, description: String) {
        self.image = image
        self.title = title
        self.description = description
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: Margin.micro) {
            HStack(spacing: Margin.micro) {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Sizes.small, height: Sizes.small)
                Text(title)
                    .textStyle(.greyMicroRegular)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                Spacer(minLength: 0)
            }
            .padding([.top, .leading], Margin.micro)
            Text(description)
                .textStyle(.whiteSmallBold)
                .padding(Margin.micro)
        }
        .padding(Margin.micro)
        .defaultLightCard()
    }
}

#if DEBUG
struct CharacteristicTileView_Previews: PreviewProvider {
    static var previews: some View {
        CharacteristicTileView(
            image: .clockTower,
            title: "STRENGTH",
            description: "14"
        )
            .frame(width: 104, height: 44)
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.appDark)
        CharacteristicTileView(
            image: .newspaper,
            title: "Kolor skóry",
            description: "Niebieskie"
        )
            .frame(width: 84, height: 44)
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.appDark)
    }
}
#endif
