//
//  NovaPoshtaBranchesOfCityXDTO.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 23.07.2024.
//

import Foundation
struct NovaPoshtaBranchesOfCityXDTO: Codable, Hashable{
    var id: String {UUID}
    var UUID: String
    var Departments: [String]
    var NameCity: String
    var NameRegion: String
}
