import SwiftUI

public extension View {
    func mirror() -> some View {
        rotation3DEffect(
            Angle(degrees: 180),
            axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0))
        )
    }

    func flipAnimation(isFlipped: Bool) -> some View {
        rotation3DEffect(
            isFlipped ? Angle(degrees: 180) : Angle(degrees: 0),
            axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0))
        )
    }

    func fullWidth(alignment: Alignment = .center) -> some View {
        frame(minWidth: 0, maxWidth: .infinity, alignment: alignment)
    }

    func background(color: Color) -> some View {
        background(color.edgesIgnoringSafeArea(.all))
    }

    func defaultCard() -> some View {
        background(Color.appDark)
            .cornerRadius(CornerRadius.standard)
    }

    func defaultLightCard() -> some View {
        background(Color.appLightDark)
            .cornerRadius(CornerRadius.standard)
    }

    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
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
    static func reduce(value _: inout CGSize, nextValue _: () -> CGSize) {}
}
