//
//  Constant.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 16.03.2024.
//

import SwiftUI


// DATA
/*
let players: [Player] = Bundle.main.decode("player.json")
let categories: [Category] = Bundle.main.decode("category.json")
 */
let products: [Product] = Bundle.main.decode("product.json")
/*
let brands: [Brand] = Bundle.main.decode("brand.json")
 */
let sampleProduct: Product = products[0]


// COLOR

let colorBackground: Color = Color("ColorBackground")
let colorGray: Color = Color(UIColor.systemGray4)

/*
// LAYOUT

let columnSpacing: CGFloat = 10
 */
let rowSpacing: CGFloat = 10
var gridLayout: [GridItem] {
  return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 2)
}

// UX

let feedback = UIImpactFeedbackGenerator(style: .medium)

var groupWithNomenclatures: [GroupWithNomenclatures] = []
//var nomenclatures: [Nomenclature2] = []
var basket: [Basket] = []
var orders: [OrdersXDTO] = []
var balances_: [SaleXDTO] = []
var balanceSum: [SaleXDTO] = []
var isAviableOnly: Bool = false
// API
// IMAGE
// FONT
// STRING
// MISC
