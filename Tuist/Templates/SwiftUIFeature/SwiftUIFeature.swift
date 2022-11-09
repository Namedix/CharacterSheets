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
            templatePath: "AppDelegate.stencil"
        ),

        // Create MVVM+C Sources
        .file(
            path: appPath + "/Sources" + "/\(nameAttribute)ViewModel.swift",
            templatePath: "ViewModel.stencil"
        ),
        .file(
            path: appPath + "/Sources" + "/\(nameAttribute)View.swift",
            templatePath: "View.stencil"
        ),
        .file(
            path: appPath + "/Sources" + "/\(nameAttribute)Coordinator.swift",
            templatePath: "Coordinator.stencil"
        ),
        .file(
            path: appPath + "/Sources" + "/\(nameAttribute)Environment.swift",
            templatePath: "Environment.stencil"
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
