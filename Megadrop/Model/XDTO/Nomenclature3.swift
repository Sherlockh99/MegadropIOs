//
//  Nomenclature3.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 04.03.2024.
//

import Foundation
struct Nomenclature3: Codable, Hashable, Identifiable{
    var id: String {IDNomenclature}
    var IDNomenclature: String
    var Nomenclature: String
    var Image: String?
    var Price: Double
}
