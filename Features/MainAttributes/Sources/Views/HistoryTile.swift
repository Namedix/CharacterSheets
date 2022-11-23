//
//  HistoryTile.swift
//  MainAttributes
//
//  Created by Bartek Pichalski on 23/11/2022.
//  Copyright © 2022 com.rook. All rights reserved.
//

import Foundation
import SwiftUI
import CommonUI

struct HistoryTile: View {
    let title: String
    let description: String

    var body: some View {
        HStack {
            Group {
                Text(title + ": ")
                    .textStyle(.whiteSmallBold)
                +
                Text(description.isEmpty ? "-" : description)
                    .textStyle(.greySmallRegular)
            }
            .multilineTextAlignment(.leading)
            Spacer()
        }
        .padding(Margin.small)
        .defaultLightCard()
    }
}
