//
//  PictureNomenclature.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 28.02.2024.
//

import Foundation
struct PictureNomenclature: Codable, Hashable, Identifiable{
    var id: String {Code}
    var Code: String
    var Image: String?
    var Nomenclature: String
}
