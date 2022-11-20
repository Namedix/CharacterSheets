import SwiftUI

public struct AmountTileView: View {
    let value: Int
    let addAction: () -> Void
    let reduceAction: () -> Void

    public init(
        value: Int,
        addAction: @escaping () -> Void,
        reduceAction: @escaping () -> Void
    ) {
        self.value = value
        self.addAction = addAction
        self.reduceAction = reduceAction
    }

    public var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Text("\(value)")
                .textStyle(.whiteBigBold)
                .padding(.horizontal, Margin.small)
            Spacer()
            buttonView
                .frame(height: 33)
                .padding(.bottom, Margin.small)
        }
        .padding(.horizontal, Margin.small)
        .defaultLightCard()
    }

    var buttonView: some View {
        HStack(spacing: 0) {
            Button(action: reduceAction) {
                Text("-")
                    .textStyle(.whiteLargeMedium)
                    .fullWidth()
                    .padding(.bottom, Margin.micro)
                    .background(Color.appDark)
            }
            Rectangle()
                .frame(width: 1)
                .foregroundColor(.appLightDark)
                .padding(.vertical, Margin.micro)
            Button(action: addAction) {
                Text("+")
                    .textStyle(.whiteLargeMedium)
                    .fullWidth()
                    .padding(.bottom, Margin.micro)
                    .background(Color.appDark)
            }
        }
        .defaultCard()
    }
}

struct AmountTileView_Previews: PreviewProvider {
    static var previews: some View {
        AmountTileView(value: 100, addAction: {}, reduceAction: {})
            .previewLayout(.sizeThatFits)
    }
}
