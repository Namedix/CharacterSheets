import SwiftUI
import CommonUI

public struct AppCircleView: View {
    var didUse: Bool

    public init(
        didUse: Bool
    ) {
        self.didUse = didUse
    }

    public var body: some View {
        Circle()
            .stroke(style: .regularStroke)
            .frame(width: Sizes.small, height: Sizes.small)
            .foregroundColor(didUse ? .appLightPurple : .appGrey)
            .background(
                Circle().foregroundColor(didUse ? .appLightPurple : .appDark)
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
