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
}
