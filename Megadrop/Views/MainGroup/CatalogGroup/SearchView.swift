//
//  SearchView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 25.05.2024.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @EnvironmentObject var shop: Shop
    
    var body: some View {
        HStack{
            //START: TEXTFILED
            TextField("Поиск...", text: $searchText)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        
                        Image(systemName: "")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        Button(action: {
                            if searchText == "" {
                                shop.isGroupsCatalog = true
                                shop.isGroupCatalog = false
                                shop.isSearchCatalog = false
                                shop.searchingValue = ""
                            }else{
                                shop.isSearchCatalog = true
                                shop.isGroupCatalog = false
                                shop.isGroupsCatalog = false
                                shop.searchingValue = searchText
                                print(searchText)
                                shop.searchingValues = GroupManager.shared.findNomenclatures(containing: shop.searchingValue)
                            }
                        
                        }) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        } //END: BUTTON
                    } //END: HSTACK
                )
                .padding(.horizontal, 10)
                .onAppear{
                    searchText = shop.searchingValue
                }
        } //END: HStack
    }
}

#Preview {
    SearchView()
        .environmentObject(Shop())
}
