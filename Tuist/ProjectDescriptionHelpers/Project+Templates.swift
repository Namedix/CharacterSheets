import ProjectDescription

// MARK: - Properties

public enum uFeatureTarget {
    case framework
    case tests
    case testing
    case preview
}

let bundlePrefix: String = "com.rook"
let deploymentTargetVersion: String = "14.0"

// MARK: - Target

extension Target {
    public static func makeAppTargets(
        name: String,
        dependencies: [TargetDependency] = [],
        testDependencies: [TargetDependency] = [],
        launchArguments: [LaunchArgument] = [],
        containsTests: Bool = true
    ) -> [Target] {
        var appTargets: [Target] = []
		let appConfigurations: [Configuration] = [
			.debug(
				name: "Debug",
				settings: .init()
					.manualCodeSigning(
						identity: "Apple Development",
						provisioningProfileSpecifier: "Character Sheets"
					),
				xcconfig: .relativeToRoot("Configurations/iOS/iOS-Application.xcconfig")
			),
			.release(name: "Release", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/iOS/iOS-Application.xcconfig")),
		]
		let testsConfigurations: [Configuration] = [
			.debug(name: "Debug", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/iOS/iOS-Base.xcconfig")),
			.release(name: "Release", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/iOS/iOS-Base.xcconfig")),
		]
        appTargets.append(
            Target(
                name: name,
                platform: .iOS,
                product: .app,
                bundleId: "\(bundlePrefix).app",
                deploymentTarget: .iOS(targetVersion: deploymentTargetVersion, devices: .iphone),
				infoPlist: .extendingDefault(with: ["UILaunchStoryboardName": "LaunchScreen"]),
                sources: ["Features/\(name)/Sources/**/*.swift"],
                resources: ["Features/\(name)/Resources/**/*" ],
                dependencies: dependencies,
				settings: .settings(configurations: appConfigurations),
                launchArguments: launchArguments
            )
        )
        if containsTests {
            appTargets.append(
                Target(
                    name: "\(name)Tests",
                    platform: .iOS,
                    product: .unitTests,
                    bundleId: "\(bundlePrefix).\(name)Tests",
                    deploymentTarget: .iOS(targetVersion: deploymentTargetVersion, devices: .iphone),
                    infoPlist: .default,
                    sources: ["Features/\(name)/Tests/**/*.swift"],
                    dependencies: [
                        .target(name: name),
                        .xctest
                    ] + testDependencies,
					settings: .settings(configurations: testsConfigurations)
                )
            )
        }
        return appTargets
    }

    public static func makeFrameworkTargets(
        name: String,
        dependencies: [TargetDependency] = [],
        testDependencies: [TargetDependency] = [],
        previewDependencies: [TargetDependency] = [],
        targets: Set<uFeatureTarget> = Set([.framework, .tests, .preview, .testing]),
        containsResources: Bool = false,
        dependsOnXCTest: Bool = false,
        bridgingHeaderPath: String? = nil,
        frameworkInfoPlist: InfoPlist = .default
    ) -> [Target] {
        // Test dependencies
        var targetTestDependencies: [TargetDependency] = [
            .target(name: "\(name)"),
            .xctest
        ] + testDependencies

        if targets.contains(.testing) {
            targetTestDependencies.append(.target(name: "\(name)Testing"))
        }

        // Target dependencies
        var targetDependencies: [TargetDependency] = dependencies
        if dependsOnXCTest {
            targetDependencies.append(.xctest)
        }

		// Configurations
		let frameworkConfigurations: [Configuration] = [
			.debug(name: "Debug", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/iOS/iOS-Framework.xcconfig")),
			.release(name: "Release", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/iOS/iOS-Framework.xcconfig")),
		]
		let testsConfigurations: [Configuration] = [
			.debug(name: "Debug", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/iOS/iOS-Base.xcconfig")),
			.release(name: "Release", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/iOS/iOS-Base.xcconfig")),
		]
		let appConfigurations: [Configuration] = [
			.debug(
				name: "Debug",
				settings: .init()
					.manualCodeSigning(
						identity: "Apple Development",
						provisioningProfileSpecifier: "Character Sheets"
					),
				xcconfig: .relativeToRoot("Configurations/iOS/iOS-Application.xcconfig")
			),
			.release(name: "Release", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/iOS/iOS-Application.xcconfig")),
		]

        // Targets
        var projectTargets: [Target] = []
        if targets.contains(.framework) {
            projectTargets.append(
                Target(
                    name: name,
                    platform: .iOS,
                    product: .framework,
                    bundleId: "\(bundlePrefix).\(name)",
                    deploymentTarget: .iOS(targetVersion: deploymentTargetVersion, devices: .iphone),
                    infoPlist: frameworkInfoPlist,
                    sources: ["Features/\(name)/Sources/**"],
                    resources: containsResources ? ["Features/\(name)/Resources/**/*"] : [],
                    dependencies: targetDependencies,
					settings: .settings(configurations: frameworkConfigurations)
                )
            )
        }
        if targets.contains(.testing) {
            projectTargets.append(
                Target(
                    name: "\(name)Testing",
                    platform: .iOS,
                    product: .framework,
                    bundleId: "\(bundlePrefix).\(name)Testing",
                    deploymentTarget: .iOS(targetVersion: deploymentTargetVersion, devices: .iphone),
                    infoPlist: .default,
                    sources: ["Features/\(name)/Testing/**/*.swift"],
                    resources: ["Features/\(name)/Testing/**/*"],
                    dependencies: targetDependencies.contains(.target(name: "Common")) ?
                        [.target(name: "\(name)"), .target(name: "Common")] :
                        [.target(name: "\(name)")],
					settings: .settings(configurations: frameworkConfigurations)
                )
            )
        }
        if targets.contains(.tests) {
            projectTargets.append(
                Target(
                    name: "\(name)Tests",
                    platform: .iOS,
                    product: .unitTests,
                    bundleId: "\(bundlePrefix).\(name)Tests",
                    deploymentTarget: .iOS(targetVersion: deploymentTargetVersion, devices: .iphone),
                    infoPlist: .default,
                    sources: ["Features/\(name)/Tests/**/*.swift"],
                    dependencies: targetTestDependencies,
					settings: .settings(configurations: testsConfigurations)
                )
            )
        }
        if targets.contains(.preview) {
            projectTargets.append(
                Target(
                    name: "\(name)Preview",
                    platform: .iOS,
                    product: .app,
                    bundleId: "\(bundlePrefix).\(name)Preview",
                    deploymentTarget: .iOS(targetVersion: deploymentTargetVersion, devices: .iphone),
                    infoPlist: .extendingDefault(with: ["UILaunchStoryboardName": "LaunchScreen"]),
                    sources: ["Features/\(name)/Preview/**/*.swift"],
                    dependencies: targets.contains(.testing) ?
                        [.target(name: "\(name)"), .target(name: "\(name)Testing")] + previewDependencies :
                        [.target(name: "\(name)")] + previewDependencies,
					settings: .settings(configurations: appConfigurations)
                )
            )
        }
        return projectTargets
    }
}
