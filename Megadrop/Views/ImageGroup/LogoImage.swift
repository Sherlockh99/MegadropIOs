//
//  CircleImage.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 07.01.2024.
//

import SwiftUI

struct LogoImage: View {
    var image: Image
    
    var body: some View {
        VStack(alignment: .leading){
            image
                .renderingMode(.original)
                .resizable()
                .frame(width: 250, height: 250)
                //.cornerRadius(5)
                //.clipShape(Circle())
                //.resizable()
                //.aspectRatio(contentMode: .fit)
                //.clipShape(Circle())
                //.padding()
        }
        //.padding(.leading, 15)
    }
}

#Preview {
    LogoImage(image: Image("logo"))
}
