//
//  SearchCatalogView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 26.05.2024.
//

import SwiftUI

struct SearchCatalogView: View {
    @EnvironmentObject var shop: Shop
    //@State var nom5: [Nomenclature2] = []
    let columns = [
           GridItem(.flexible()),
           GridItem(.flexible())
       ]
    
    var body: some View {
        VStack{
            NavigationBarSearchListNomenclatureView()
                .background(Color.gray)
            
            SearchView()
                ScrollView{
                    LazyVGrid(columns: columns, spacing: 10){
                        ForEach(shop.searchingValues, id: \.self){ key in
                            //HomePageNomenclature(IDGroup: shop.idGroupCatalog, nomenclature: key)
                            HomePageNomenclature(IDGroup: "00001", nomenclature: key)
                                .frame(maxWidth: .infinity)
                                //.background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                                .padding(5)
                                .onTapGesture {
                                    feedback.impactOccurred()
                                    
                                    withAnimation(.easeOut) {
                                        shop.selectedNomenclatureCatalog = key
                                        shop.isGroupCatalog = false
                                        shop.isSearchCatalog = false
                                        shop.isNomenclatureCatalog = true
                                    }
                                }
                        }
                    }
                }
        }
    }
}

#Preview {
    SearchCatalogView()
        .environmentObject(Shop())
}
