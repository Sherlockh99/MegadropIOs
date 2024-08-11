//
//  SaleXDTO.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 31.07.2024.
//

import Foundation
struct SaleXDTO: Codable, Hashable{
    let AmountContractor: Double
    let AmountDebt: Double
    let AmountDocument: Double
    let AmountNovaPoshta: Double
    let Contractor: String
    let DateTime: String
    let Date: String
    let Time: String
    let Duty: Double
    let Field3: String
    let Link: String
    let TypeOfPayment: Int?
}
