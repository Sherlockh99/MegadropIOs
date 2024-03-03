//
//  CircleImage.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 27.01.2024.
//

import SwiftUI

struct LogoCircleImage: View {
    var image: Image
    
    var body: some View {
        image
            .resizable()
            .frame(width: 250, height: 250)
            .clipShape(Circle())
            .overlay{
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

#Preview {
    LogoCircleImage(image: Image("logo"))
}
