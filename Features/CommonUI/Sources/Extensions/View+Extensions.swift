import SwiftUI

extension View {
    public func mirror() -> some View {
        self.rotation3DEffect(
            Angle(degrees: 180),
            axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0))
        )
    }

    public func flipAnimation(isFlipped: Bool) -> some View {
        self.rotation3DEffect(
            isFlipped ? Angle(degrees: 180) : Angle(degrees: 0),
            axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0))
        )
    }

    public func fullWidth(alignment: Alignment = .center) -> some View {
        frame(minWidth: 0, maxWidth: .infinity, alignment: alignment)
    }

    public func background(color: Color) -> some View {
        background(color.edgesIgnoringSafeArea(.all))
    }

    public func defaultCard() -> some View {
        self.background(Color.appDark)
            .cornerRadius(CornerRadius.standard)
    }

    public func defaultLightCard() -> some View {
        self.background(Color.appLightDark)
            .cornerRadius(CornerRadius.standard)
    }

    public func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
