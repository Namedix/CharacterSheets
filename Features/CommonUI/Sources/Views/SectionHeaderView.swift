import SwiftUI

public struct SectionHeaderView: View {
    let title: String
    let image: Image?
    let rightAction: () -> Void
    let secondaryImage: Image?
    let secondaryRightAction: () -> Void

    public init(
        title: String,
        image: Image? = nil,
        rightAction: @escaping () -> Void = {},
        secondaryImage: Image? = nil,
        secondaryRightAction: @escaping () -> Void = {}
    ) {
        self.title = title
        self.image = image
        self.rightAction = rightAction
        self.secondaryImage = secondaryImage
        self.secondaryRightAction = secondaryRightAction
    }

    public var body: some View {
        HStack {
            Text(title)
                .textStyle(.whiteMediumBold)
                .shadow(
                    color: Color.appWhite.opacity(0.2),
                    radius: 15, x: 0, y: 1
                )
            Spacer()
            Button(action: secondaryRightAction) {
                secondaryImage?
                    .resizable()
                    .frame(width: Sizes.normal, height: Sizes.normal)
            }
            .padding(.trailing, Margin.large)
            Button(action: rightAction) {
                image?
                    .resizable()
                    .frame(width: Sizes.normal, height: Sizes.normal)
            }
        }
        .padding(.horizontal, Margin.regular)
        .padding(.vertical, Margin.small)
    }
}

#if DEBUG
    struct SectionHeader_Previews: PreviewProvider {
        static var previews: some View {
            SectionHeaderView(
                title: L10n.characterListTitle,
                image: Image(systemName: "gear"),
                rightAction: {}
            )
            .padding()
            .background(color: .appBlackDark)
            .previewLayout(.sizeThatFits)
            SectionHeaderView(
                title: L10n.characterListTitle
            )
            .padding()
            .background(color: .appBlackDark)
            .previewLayout(.sizeThatFits)
        }
    }
#endif
