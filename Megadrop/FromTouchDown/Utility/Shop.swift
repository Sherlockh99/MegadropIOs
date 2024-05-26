//
//  Shop.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 16.03.2024.
//

import Foundation
class Shop: ObservableObject {
    @Published var showingProduct: Bool = false
    @Published var selectedProduct: Product? //= nil
    @Published var showingNomenclature: Bool = false
    @Published var selectedNomenclature: Nomenclature2? //= nil
    @Published var IDGroup: String = ""
    @Published var isGroupsCatalog: Bool = true
    @Published var isGroupCatalog: Bool = false
    @Published var idGroupCatalog: String = ""
    @Published var isNomenclatureCatalog: Bool = false
    @Published var selectedNomenclatureCatalog: Nomenclature2? //= nil
    @Published var isSearchCatalog: Bool = false
    @Published var searchingValue: String = ""
    @Published var searchingValues: [Nomenclature2] = []
}
