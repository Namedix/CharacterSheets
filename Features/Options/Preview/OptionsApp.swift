import Misc
import Options
import SwiftUI

@main
struct OptionsApp: App {
    var body: some Scene {
        WindowGroup {
            OptionsView(
                store: .init(initialState: Options.State(), reducer: Options())
            )
        }
    }
}
