import SwiftUI

public struct TextStyle {
    public let font: Font
    public let color: Color
}

public extension View {
    func textStyle(_ style: TextStyle) -> some View {
        font(style.font).foregroundColor(style.color)
    }
}
