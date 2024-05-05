//
//  Nomenclature2.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 20.02.2024.
//

import Foundation
struct Nomenclature2: Codable, Hashable, Identifiable{
    var id: String {IDNomenclature}
    var IDGroup: String
    var IDNomenclature: String
    var Nomenclature: String
    var Image: String?
    var Price: Int = 0
    var VendorCode: String
    var Available: Bool
    var Details: String!=""
    var Favorite: Bool?
    var Characteristics: [Characteristicses]?
    
    init(){
        IDGroup = "1"
        IDNomenclature = "1"
        Nomenclature = "1"
        VendorCode = "1"
        Available = false
        IDGroup = "1"
    }
    
    var formattedPrice: String { return "\(Price) грн." }
}
