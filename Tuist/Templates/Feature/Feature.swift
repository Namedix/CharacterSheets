//
//  FeatureUIKit.swift
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
    description: "Create feature without Preview target",
    attributes: [
        nameAttribute,
        .optional("platform", default: "ios")
    ],
    items: [
        // Create Sources
        .file(
            path: appPath + "/Sources" + "/Empty.swift",
            templatePath: "Empty.stencil"
        ),

        // Create Tests
        .file(
            path: appPath + "/Tests" + "/\(nameAttribute)Tests.swift",
            templatePath: "AppTests.stencil"
        )
    ]
)
