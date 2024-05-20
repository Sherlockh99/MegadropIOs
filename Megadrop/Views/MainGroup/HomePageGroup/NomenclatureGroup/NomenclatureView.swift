//
//  NomenclatureView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 10.02.2024.
//

import SwiftUI

struct NomenclatureView: View {
    let IDGroup: String
    let nomenclature: Nomenclature2
    
    @EnvironmentObject var shop: Shop
    
    var image: Image{
        Image("logo")
    }
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 5, content: {
                // NAVBAR
                
                NavigationBarDetailView()
                    .padding(.horizontal)
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
               
                
                //HEADER
                //HeaderDetailView()
                //    .padding(.horizontal)
                
                // DETAIL TOP PART
                TopPartDetailView(IDGroup: IDGroup)
                    .padding(.horizontal)
                    .zIndex(1)
                DetailsView(IDGroup: IDGroup, nom3: nomenclature)
            })//: VSTACK
            .zIndex(0)
            .ignoresSafeArea(.all, edges: .all)
            .background(
               Color(
                   red: shop.selectedProduct?.red ?? sampleProduct.red,
                    green: shop.selectedProduct?.green ?? sampleProduct.green,
                   blue: shop.selectedProduct?.blue ?? sampleProduct.blue
               ).ignoresSafeArea(.all, edges: .all)
            )
                 
        }
    }
}

#Preview {

    NomenclatureView(IDGroup: ModelData().groupsWithNomenclatures[0].IDGroup,
                     nomenclature: ModelData().groupsWithNomenclatures[0].Nomenclatures![0])
        .environmentObject(Shop())
        .previewLayout(.fixed(width: 375, height: 812))
     
}
