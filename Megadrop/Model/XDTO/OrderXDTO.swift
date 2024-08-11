//
//  OrderXDTO.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 30.07.2024.
//

import Foundation
struct OrdersXDTO: Codable, Hashable{
    let CounterParty: String
    let DateOrder: String
    let Difference: Double
    let IDOrder: String
    let StatusOrder: String
    let StatusShipping: String
    let SumOrder: Int
    let SumPay: Double
    let TTN: String
    let TelephoneNumber: String
    let TypePayment: String
}
