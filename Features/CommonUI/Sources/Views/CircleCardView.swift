//
//  CircleCardView.swift
//  CommonUI
//
//  Created by Bartek Pichalski on 23/11/2022.
//  Copyright © 2022 com.rook. All rights reserved.
//

import SwiftUI

public struct CircleCardView: View {

    // MARK: - Properties

    let image: Image?
    let title: String?
    let description: String
    let hasBackground: Bool

    // MARK: - Initialization

    public init(image: Image? = nil, title: String? = nil, description: String, hasBackground: Bool = true) {
        self.image = image
        self.title = title
        self.description = description
        self.hasBackground = hasBackground
    }

    // MARK: - View

    public var body: some View {
        VStack {
            ZStack {
                Circle()
                    .foregroundColor(.appDark)
                if let image = image {
                    image
                        .resizable()
                        .frame(width: Sizes.huge, height: Sizes.huge)
                } else if let title = title {
                    Text(title)
                        .textStyle(.whiteBigBold)
                        .frame(width: Sizes.huge, height: Sizes.huge)
                }
            }
            .padding(.top, Margin.small)
            .padding(.horizontal, Margin.medium)
            Text(description)
                .textStyle(.greyRegular)
                .padding(.top, Margin.small)
            Spacer()
        }
        .background(color: hasBackground ? .appLightDark : .clear)
        .cornerRadius(CornerRadius.standard)
    }
}
