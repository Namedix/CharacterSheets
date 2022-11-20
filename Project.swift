import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Configurations

let configurations: [Configuration] = [
    .debug(name: "Debug", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/Base/Configurations/Debug.xcconfig")),
    .release(name: "Release", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/Base/Configurations/Release.xcconfig")),
]

// MARK: - Targets

var targets: [Target] {
    var targets: [Target] = []
    targets += Target.makeAppTargets(
        name: "App",
        dependencies: [
            .target(name: "CharacterSelection"),
        ],
        containsTests: false
    )
    targets += Target.makeFrameworkTargets(
        name: "Common",
        dependencies: [
            .package(product: "ComposableArchitecture"),
        ],
        targets: [.framework]
    )
    targets += Target.makeFrameworkTargets(
        name: "CommonUI",
        dependencies: [],
        targets: [.framework],
        containsResources: true
    )
    targets += Target.makeFrameworkTargets(
        name: "CharacterSelection",
        dependencies: [
            .target(name: "Common"),
            .target(name: "CommonUI"),
            .target(name: "Tabs"),
        ],
        targets: [.preview, .framework]
    )
    targets += Target.makeFrameworkTargets(
        name: "Tabs",
        dependencies: [
            .target(name: "Common"),
            .target(name: "CommonUI"),
            .target(name: "Options"),
            .target(name: "Equipment"),
        ],
        targets: [.preview, .framework]
    )
    targets += Target.makeFrameworkTargets(
        name: "Options",
        dependencies: [
            .target(name: "Common"),
            .target(name: "CommonUI"),
        ],
        targets: [.preview, .framework]
    )
    targets += Target.makeFrameworkTargets(
        name: "Equipment",
        dependencies: [
            .target(name: "Common"),
            .target(name: "CommonUI"),
            .external(name: "SwiftUIMasonry"),
        ],
        targets: [.preview, .framework]
    )
    return targets
}

// MARK: - Project

let project = Project(
    name: "CharacterSheets",
    organizationName: "com.rook",
    packages: [
        .remote(url: "https://github.com/pointfreeco/swift-composable-architecture.git", requirement: .upToNextMajor(from: "0.45.0")),
    ],
    settings: .settings(configurations: configurations),
    targets: targets,
    resourceSynthesizers: [.assets(), .strings(), .fonts()]
)
