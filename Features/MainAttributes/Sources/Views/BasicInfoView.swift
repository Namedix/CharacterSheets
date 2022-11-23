//
//  BasicInfoModuleView.swift
//  Character
//
//  Created by Adam Tokarczyk on 03/11/2020.
//

import SwiftUI
import CommonUI

struct BasicInfoView: View {
    let name: String
    let profession: String
    let professionImageName: String
    let time: String

    var body: some View {
        VStack(spacing: Margin.medium) {
            LazyVGrid(
                columns: [GridItem(.flexible()), GridItem(.fixed(100))],
                alignment: .center,
                spacing: Margin.large
            ) {
                info(
                    image: .scrollUnfurled2,
                    title: "Nazwa:",
                    description: name
                ).fullWidth(alignment: .leading)
                Spacer()
                info(
                    image: Image(professionImageName, bundle: CommonUIResources.bundle),
                    title: "Profesja",
                    description: profession
                ).fullWidth(alignment: .leading)
                detail(
                    image: .clockTower,
                    title: "Lata:",
                    description: time
                )
            }
            .padding(Margin.medium)
            .defaultCard()
        }
        .background(Color.appBlackDark)
    }

    private func info(image: Image, title: String, description: String) ->  some View {
        HStack(spacing: Margin.small) {
            image
            VStack(alignment: .leading) {
                Text(title)
                    .textStyle(.greyMicroMedium)
                Text(description)
                    .textStyle(.whiteMediumMedium)
                    .lineLimit(2)
            }
        }
    }

    private func detail(
        image: Image,
        title: String,
        description: String
    ) -> some View {
        HStack(spacing: Margin.small) {
            image
            VStack(alignment: .leading) {
                Text(title)
                    .textStyle(.greyMicroMedium)
                Text(description)
                    .textStyle(.whiteMediumMedium)
            }
            Spacer(minLength: 0)
        }
    }
}
