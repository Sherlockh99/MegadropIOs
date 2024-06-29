//
//  CatalogView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 27.01.2024.
//

import SwiftUI

struct CatalogView: View {

    @EnvironmentObject var shop: Shop
    
    var body: some View {
        if shop.isNomenclatureCatalog {
            if let nom3 = shop.selectedNomenclatureCatalog {
                NomenclatureView(IDGroup: shop.idGroupCatalog, nomenclature: nom3)
            }
        }else{
            VStack{ //START: VSTACK
                if(shop.isGroupsCatalog){
                    GroupsCatalogView()
                } else if shop.isGroupCatalog {
                    GroupCatalogView()
                } else if shop.isSearchCatalog {
                    SearchCatalogView()
                }
            }
            .onAppear{
                if groupWithNomenclatures.count>0 &&
                    !shop.isGroupCatalog &&
                    shop.selectedNomenclatureCatalog == nil{
                    shop.isGroupsCatalog = true
                }else{
                    shop.isGroupsCatalog = false
                }
            }
            //END: VSTACK
        } //END: END IF
        //END: VSTACK
    } //:BODY
}

#Preview {
    CatalogView()
        .environmentObject(Shop())
}
