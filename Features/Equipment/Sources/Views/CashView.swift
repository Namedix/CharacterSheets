//
//  CashView.swift
//  Equipment
//
//  Created by Bartek Pichalski on 20/11/2022.
//  Copyright © 2022 com.rook. All rights reserved.
//

import CommonUI
import SwiftUI

struct CashView: View {
    let image: Image
    let value: Int
    let currency: String
    let isFlipped: Bool
    let addAction: () -> Void
    let reduceAction: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            if isFlipped {
                CircleCardView(
                    image: image,
                    description: "\(value) \(currency)",
                    hasBackground: false
                )
            } else {
                AmountTileView(value: value, addAction: addAction, reduceAction: reduceAction)
                    .flipAnimation(isFlipped: true)
            }
        }
        .defaultLightCard()
        .flipAnimation(isFlipped: !isFlipped)
    }
}
