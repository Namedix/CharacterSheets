import SwiftUI

public struct AppCircleView: View {
    var didUse: Bool

    public init(
        didUse: Bool
    ) {
        self.didUse = didUse
    }

    public var body: some View {
        Circle()
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [4, 1]))
            .frame(width: 15, height: 15)
            .foregroundColor(didUse ? Color.appLightPurple : Color.appGrey)
            .background(
                Circle().foregroundColor(didUse ? Color.appLightPurple : Color.appDark)
            )
    }
}

struct AppCircleView_Previews: PreviewProvider {
    static var previews: some View {
        AppCircleView(
            didUse: true
        )
    }
}
