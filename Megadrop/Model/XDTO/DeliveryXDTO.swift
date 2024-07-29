//
//  DeliveryXDTO.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 22.07.2024.
//

import Foundation
struct DeliveryXDTO: Codable, Hashable{
    var id: String {UUID}
    var UUID: String
    var District: String
    var Index: String
    var Locality: String
    var Region: String
}
