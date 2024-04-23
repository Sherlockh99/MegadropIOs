//
//  BasketReplyDTO.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 20.04.2024.
//

import Foundation
struct BasketReply: Codable, Hashable{
    let Count: Int
    let IDNomenclature: String
    let IDCharacteristic: String
    let NameCharacteristic: String
    let Price: Double
}
