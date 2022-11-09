import SwiftUI

public struct InfoTileView: View {
    let image: Image
    let title: String
    let description: String

    public init(image: Image, title: String, description: String) {
        self.image = image
        self.title = title
        self.description = description
    }

    public var body: some View {
        HStack(spacing: Margin.large) {
            image
                .resizable()
                .scaledToFit()
                .frame(width: Sizes.big, height: Sizes.big)
                .padding(Margin.small)
                .defaultLightCard()
                .padding([.leading, .vertical], Margin.regular)
            VStack(alignment: .leading, spacing: Margin.micro) {
                Text(title)
                    .textStyle(description.isEmpty ? .whiteMediumBold : .whiteSmallBold)
                if !description.isEmpty {
                    Text(description)
                        .textStyle(.greyTinyMedium)
                        .multilineTextAlignment(.leading)
                }
            }.padding(.vertical, Margin.small)
            Spacer()
        }
    }
}

#if DEBUG
    struct SimpleInfoTile_Previews: PreviewProvider {
        static var previews: some View {
            InfoTileView(
                image: Image.crossedSwords,
                title: "Namedix",
                description: "Dzielny wojownik, przystojny chłopak, szlachcic"
            )
            .previewLayout(.sizeThatFits)
        }
    }
#endif
