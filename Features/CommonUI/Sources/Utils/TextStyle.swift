import SwiftUI

public struct TextStyle {
    public let font: Font
    public let color: Color
}

extension View {
    public func textStyle(_ style: TextStyle) -> some View {
        font(style.font).foregroundColor(style.color)
    }
}
