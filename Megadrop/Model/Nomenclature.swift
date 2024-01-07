//
//  Nomenclature.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 28.01.2024.
//

import Foundation

struct Nomenclature: Codable, Hashable, Identifiable{
    var id: String {IDNomenclature}
    var IDNomenclature: String
    var Nomenklature: String
    var Image: String
    var Price: Int
    var VendorCode: String
    var Available: Bool
}
