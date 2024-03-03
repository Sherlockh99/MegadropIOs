//
//  Nomenclature2.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 20.02.2024.
//

import Foundation
struct Nomenclature2: Codable, Hashable, Identifiable{
    var id: String {IDNomenclature}
    var IDNomenclature: String
    var Nomenclature: String
    var Image: String?
    var Price: Int = 0
    var VendorCode: String
    var Available: Bool
    var Details: String!=""
    var Favorite: Bool?
    var Characteristics: [Characteristicses]?
}

struct Characteristicses: Codable, Hashable, Identifiable{
    var id: Int{IDCharacteristic}
    var IDCharacteristic: Int
    var Characteristic: String
    var Price: Double = 0.0
    var OrderedQuality: Double = 0.0
    var isCharacteristic: Bool
}
