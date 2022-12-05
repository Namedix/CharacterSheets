//
//  MinusPlusRow.swift
//  CommonUI
//
//  Created by Adam Tokarczyk on 05/12/2022.
//  Copyright © 2022 com.rook. All rights reserved.
//

import SwiftUI

public struct MinusPlusRowView : View {
    let minusAction: () -> Void
    let plusAction: () -> Void


    public init(minusAction: @escaping () -> Void, plusAction: @escaping () -> Void) {
        self.minusAction = minusAction
        self.plusAction = plusAction
    }

    public var body: some View {
        ZStack {
            HStack(spacing: 0) {
                Button {
                    withAnimation {
                        minusAction()
                    }
                } label: {
                    Text("-")
                        .textStyle(.whiteTinyBold)
                        .padding(.vertical, Margin.medium)
                        .padding(.horizontal, Margin.extraLarge)
                        .background(Color.appLightDark)
                        .cornerRadius(CornerRadius.standard, corners: [.topLeft, .bottomLeft])
                }
                .buttonStyle(PlainButtonStyle())
                Button {
                    withAnimation {
                        plusAction()
                    }
                } label: {
                    Text("+")
                        .textStyle(.whiteTinyBold)
                        .padding(.vertical, Margin.medium)
                        .padding(.horizontal, Margin.extraLarge)
                        .background(Color.appLightDark)
                        .cornerRadius(CornerRadius.standard, corners: [.topRight, .bottomRight])
                }
                .buttonStyle(PlainButtonStyle())
            }
            Color.appGrey.frame(width: 1, height: Constants.small)
        }
    }
}

extension MinusPlusRowView {
    enum Constants {
        static let small: CGFloat = 30
    }
}
