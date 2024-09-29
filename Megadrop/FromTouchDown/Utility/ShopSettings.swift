//
//  Untitled.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 26.09.2024.
//

import Foundation
class ShopSettings: ObservableObject {
    @Published var isMain: Bool = true
    @Published var isMyOrders: Bool = false
    @Published var isBalance: Bool = false
    @Published var isPartner: Bool = false
    @Published var isSettings: Bool = false
    @Published var isAbout: Bool = false

}
