import ComposableArchitecture
import SwiftUI

public struct TabsView: View {
    // MARK: - Properties

    var store: StoreOf<Tabs>

    // MARK: - Initialization

    public init(store: StoreOf<Tabs>) {
        self.store = store
    }

    // MARK: - View

    public var body: some View {
        Text("Tabs")
    }
}

struct WorkspaceView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView(
            store: Store(
                initialState: .init(),
                reducer: Tabs()
            )
        )
    }
}
