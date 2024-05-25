//
//  CatalogView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 27.01.2024.
//

import SwiftUI

struct CatalogView: View {

    @EnvironmentObject var shop: Shop

    //let items = Array(1...30)  // Массив чисел от 1 до 30

    /*
    let columns: [GridItem] = [
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
        GridItem(.fixed(100))
    ] */
    
    /*
    let columns: [GridItem] = [
        GridItem(.fixed(100)),
        GridItem(.fixed(100))
    ]
    */
    
    var body: some View {
        if shop.isNomenclatureCatalog {
            if let nom3 = shop.selectedNomenclatureCatalog {
                NomenclatureView(IDGroup: shop.idGroupCatalog, nomenclature: nom3)
            }
        }else{
            VStack{ //START: VSTACK
                //if !shop.isNomenclatureCatalog {
                if shop.isGroupsCatalog {
                    SearchView()
                }
                Spacer()
                VStack{
                    if(shop.isGroupsCatalog){
                        ScrollView {
                            ForEach(groupWithNomenclatures, id: \.self) { item in
                                Button("\(item.NameGroup)"){
                                    shop.isGroupsCatalog = false
                                    shop.isGroupCatalog = true
                                    shop.idGroupCatalog = item.IDGroup
                                }
                            }
                        }
                    } else if shop.isGroupCatalog {
                        GroupCatalogView()
                    }
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
        }
        //END: VSTACK
    } //:BODY
}

#Preview {
    CatalogView()
        .environmentObject(Shop())
}
