//
//  Characteristicses.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 27.04.2024.
//

import Foundation
struct Characteristicses: Codable, Hashable, Identifiable{
    var id: Int{IDCharacteristic}
    var IDCharacteristic: Int
    var Characteristic: String
    var Price: Double = 0.0
    var OrderedQuality: Int = 0
    var isCharacteristic: Bool
}
