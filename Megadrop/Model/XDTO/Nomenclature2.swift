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
    var VendorCode: String
    var Details: String
    var Favorite: Bool
    var Available: Bool
    var Image: String?
    var Characteristics: [Characteristicses]
}

struct Characteristicses: Codable, Hashable{
    var IDCharacteristic: String
    var Characteristic: String
    var Price: Double
    var OrderedQuality: Double
    var isCharacteristic: Bool
}
