import ProjectDescription

let dependencies = Dependencies(
    carthage: [],
	swiftPackageManager: [
		.remote(url: "https://github.com/pointfreeco/swift-composable-architecture.git", requirement: .upToNextMajor(from: "0.45.0"))
	],
    platforms: [.iOS]
)
