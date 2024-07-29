//
//  BasketView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 27.01.2024.
//

import SwiftUI

struct BasketView: View {
    @ObservedObject private var viewModelBasketManager = BasketManager.sharedBasketManager
    @EnvironmentObject var shopRecycle: ShopRecycle
    @EnvironmentObject var shop: Shop
    
    var body: some View {
        ZStack{
            Color(
                red: shop.selectedProduct?.red ?? sampleProduct.red,
                green: shop.selectedProduct?.green ?? sampleProduct.green,
                blue: shop.selectedProduct?.blue ?? sampleProduct.blue
            ).ignoresSafeArea(.all, edges: .all)
            
            if shopRecycle.isBuy {
                ZStack{
                    Color.white
                            .ignoresSafeArea()
                    BuyView()
                }
            }else{
                if shopRecycle.isNomenclatureRecycle {
                    VStack{
                        ScrollView(.vertical, showsIndicators: false){
                            if !viewModelBasketManager.isLoadingBasketManager{
                                ForEach(basket,id: \.self){
                                    key in
                                    OneBasketView(basketOrder: key)
                                        .onTapGesture {
                                            feedback.impactOccurred()
                                            
                                            withAnimation(.easeOut) {
                                                let nom = GroupManager.shared.getNomenclature(groupID: key.IDGroup, nomenclatureID: key.IDNomenclature)
                                                
                                                shopRecycle.isNomenclatureRecycle = false
                                                shopRecycle.selectedNomenclatureRecycle = nom
                                                shopRecycle.idGroupCatalog = key.IDGroup
                                                
                                            }
                                        }
                                }
                            }
                        } //END: SCROLL_VIEW
                        
                        Button {
                            shopRecycle.isBuy = true
                        } label: {
                            Text("Buy")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [
                                            .customGreenLight,
                                            .customGreenMedium
                                        ],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .shadow(color: .black.opacity(0.25), radius: 0.25, x: 1, y: 2)
                        }
                        .buttonStyle(GradientButton())
                        
                    } //END: VSTACK
                    .onAppear{
                        viewModelBasketManager.loadBasket()
                    }
                    .padding(.horizontal, 15)
                }else{
                    if let nom = shopRecycle.selectedNomenclatureRecycle {
                        NomenclatureView(IDGroup: shopRecycle.idGroupCatalog, nomenclature: nom)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(10)
                            .padding(5)
                            .onTapGesture {
                                feedback.impactOccurred()
                                withAnimation(.easeOut) {
                                    shopRecycle.isNomenclatureRecycle = true
                                }
                            }
                    }
                }
            }
        }//END: ZStack
    }
}

#Preview {
    BasketView()
        .environmentObject(ShopRecycle())
        .environmentObject(Shop())
}
