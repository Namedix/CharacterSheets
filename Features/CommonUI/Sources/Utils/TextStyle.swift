import SwiftUI

public struct TextStyle {
    public let font: Font
    public let color: Color
}

public extension Text {
    func textStyle(_ style: TextStyle) -> Text {
        font(style.font).foregroundColor(style.color)
    }
}
