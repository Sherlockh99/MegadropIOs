//
//  Basket.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 27.04.2024.
//

import Foundation
struct Basket: Codable, Hashable{
    var id: String {IDNomenclature}
    var IDNomenclature: String
    var NameNomenclaure: String
    var IDCharacteristic: Int
    var NameCharacteristic: String
    var isCharacteristic: Bool
    var Price: Int
    var Count: Int
    var IDGroup: String
}
