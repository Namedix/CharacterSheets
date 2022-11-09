//
//  SwiftUIFeature.swift
//  ProjectDescriptionHelpers
//
//  Created by Namedix on 30/07/2021.
//

import ProjectDescription

// MARK: - Properties

let nameAttribute: Template.Attribute = .required("name")
let appPath = "Features/\(nameAttribute)"

// MARK: - FeatureUIKit

let template = Template(
    description: "Create feature with Preview target",
    attributes: [
        nameAttribute,
        .optional("platform", default: "ios")
    ],
    items: [
        // Create Preview
        .file(
            path: appPath + "/Preview" + "/AppDelegate.swift",
            templatePath: "App.stencil"
        ),

        // Create MVVM+C Sources
        .file(
            path: appPath + "/Sources" + "/\(nameAttribute).swift",
            templatePath: "Feature.stencil"
        ),
        .file(
            path: appPath + "/Sources" + "/\(nameAttribute)View.swift",
            templatePath: "View.stencil"
        ),

        // Create Testing
        .file(
            path: appPath + "/Testing/Empty.swift",
            templatePath: "Empty.stencil"
        ),

        // Create Tests
        .file(
            path: appPath + "/Tests" + "/\(nameAttribute)Tests.swift",
            templatePath: "AppTests.stencil"
        )
    ]
)
