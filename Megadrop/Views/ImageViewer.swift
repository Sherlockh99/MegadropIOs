//
//  ImageViewer.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 25.02.2024.
//

import SwiftUI

struct ImageViewer: View {
    @ObservedObject var imageModel: ImageModel
    
    var body: some View {
        VStack {
            if let image = imageModel.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Text("Загрузка изображения...")
                    .onAppear {
                        imageModel.loadImage()
                    }
            }
        }
    }
}
