//
//  ImageModel.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 25.02.2024.
//

import Foundation
import SwiftUI
import Combine

class ImageModel: ObservableObject {
    @Published var image: UIImage? = nil
    var imageDataString: String
    
    init(imageDataString: String) {
        self.imageDataString = imageDataString
        //if self.imageDataString.contains(",") {
       //     self.imageDataString = self.imageDataString.components(separatedBy: ",").last ?? ""
        //}
    }
    
    func loadImage() {
        
        guard let data = Data(base64Encoded: imageDataString, options: .ignoreUnknownCharacters) else { return }
        DispatchQueue.main.async {
            self.image = UIImage(data: data)
        }
    }
}
