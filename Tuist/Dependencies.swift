import ProjectDescription

let dependencies = Dependencies(
    carthage: [],
    swiftPackageManager: [
		.remote(url: "https://github.com/ciaranrobrien/SwiftUIMasonry.git", requirement: .branch("main"))
	],
    platforms: [.iOS]
)
