//
//  CashView.swift
//  Equipment
//
//  Created by Bartek Pichalski on 20/11/2022.
//  Copyright © 2022 com.rook. All rights reserved.
//

import SwiftUI
import CommonUI

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
				ZStack {
					Circle()
						.foregroundColor(.appDark)
					image
						.resizable()
						.frame(width: 50, height: 50)
				}
				.padding(.top, Margin.small)
				.padding(.horizontal, Margin.medium)
				Text("\(value) \(currency)")
					.textStyle(.greyRegular)
					.padding(.top, Margin.small)
				Spacer()
			} else {
				AmountTileView(value: value, addAction: addAction, reduceAction: reduceAction)
					.flipAnimation(isFlipped: true)
			}
		}
		.defaultLightCard()
		.flipAnimation(isFlipped: !isFlipped)
    }
}
