//
//  GroupsCatalogView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 25.05.2024.
//

import SwiftUI

struct GroupsCatalogView: View {
    @EnvironmentObject var shop: Shop
    var body: some View {
        SearchView()
        ScrollView {
            ForEach(groupWithNomenclatures, id: \.self) { item in
                Button("\(item.NameGroup)"){
                    shop.isGroupsCatalog = false
                    shop.isGroupCatalog = true
                    shop.idGroupCatalog = item.IDGroup
                }
            }
        }
    }
}

#Preview {
    GroupsCatalogView()
}
