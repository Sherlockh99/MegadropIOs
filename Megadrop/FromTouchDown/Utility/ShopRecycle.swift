//
//  ShopRecycle.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 30.05.2024.
//

import Foundation
class ShopRecycle: ObservableObject {
    @Published var isNomenclatureRecycle: Bool = true
    @Published var idGroupCatalog: String = ""
    @Published var selectedNomenclatureRecycle: Nomenclature2?
    @Published var isBuy: Bool = false
}
