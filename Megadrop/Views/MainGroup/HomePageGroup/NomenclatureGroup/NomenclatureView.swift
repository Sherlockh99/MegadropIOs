//
//  NomenclatureView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 10.02.2024.
//

import SwiftUI

struct NomenclatureView: View {
    let IDGroup: String
    @EnvironmentObject var shop: Shop
    @State private var value = 0
    @StateObject private var nomenclatureFullDataLoader = NomenclatureFullDataLoader()
    
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
                HeaderDetailView()
                    .padding(.horizontal)
                
                // DETAIL TOP PART
                TopPartDetailView(IDGroup: IDGroup)
                    .padding(.horizontal)
                    .zIndex(1)
                
                VStack(alignment: .center, spacing: 0, content: {
                   /*
                    // RATINGS + SIZES
                    RatingsSizesDetailView()
                        .padding(.top, -20)
                        .padding(.bottom, 10)
                    */
                    ScrollView(.vertical, showsIndicators: false, content: {
                        if let details = nomenclatureFullDataLoader.nomenclature2?.Details {
                            //if let details = shop.selectedNomenclature?.Details {
                            Text(details)
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.leading)
                        } else {
                            Text(shop.selectedNomenclature?.Nomenclature ?? sampleProduct.description)
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.leading)
                        }
                        
                        Spacer()
                        
                        if let nom2 = nomenclatureFullDataLoader.nomenclature2{
                            if let details = nom2.Characteristics{
                                ForEach(details,id: \.self){key in
                                    QuantityFavouriteDetailView(
                                        IDGroup: IDGroup,
                                        IDNomenclature: nom2.IDNomenclature,
                                        IDCharacteristic: key.IDCharacteristic)
                                }
                            }
                        }
                    })//: SCROLL
                                    
                    /*
                     // ADD TO CART
                     AddToCartDetailView()
                     */
                    
                })//: VSTACK
                .padding(.horizontal)
                .padding(.bottom,105)
                .background(
                    Color.white
                        .clipShape(CustomShape())
                        .padding(.top, -105)
                )
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
        .onAppear{
            if let selectedNomenclature = shop.selectedNomenclature {
                
                if selectedNomenclature.Details == nil {
                    nomenclatureFullDataLoader.loadFullNomenclatureData(
                        groupID: IDGroup,
                        idNomenclature: selectedNomenclature.IDNomenclature)
                    
                    
                }else{
                    nomenclatureFullDataLoader.decodeNomenclature(
                        groupID: IDGroup,
                        nomenclature: selectedNomenclature)
                }
                
            }
        }
    }
}

#Preview {

    NomenclatureView(IDGroup: ModelData().groupsWithNomenclatures[0].IDGroup)
        .environmentObject(Shop())
        .previewLayout(.fixed(width: 375, height: 812))
     
}
