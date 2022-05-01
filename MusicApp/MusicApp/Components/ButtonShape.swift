//
//  ButtonShape.swift
//  MusicApp
//
//  Created by Hussain Almousawi on 5/1/22.
//

import SwiftUI

struct ButtonShape: View {
    var imageName: String
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
            .padding(25)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.bg, lineWidth: 5)
                    .shadow(color: Color.shadow, radius: 5, x: 0, y: 0)
                    .shadow(color: Color.shadow, radius: 4, x: -4, y: -4)
            )
            .cornerRadius(20)
            .padding(5)
    }
}
