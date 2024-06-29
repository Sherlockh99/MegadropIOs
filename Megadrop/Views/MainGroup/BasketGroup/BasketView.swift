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
    
    var body: some View {
        if shopRecycle.isBuy {
            BuyView()
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
                    }
                    
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
                    
                }
                .onAppear{
                    viewModelBasketManager.loadBasket()
                }
            }else{
                if let nom = shopRecycle.selectedNomenclatureRecycle {
                    NomenclatureView(IDGroup: shopRecycle.idGroupCatalog, nomenclature: nom)
                        .frame(maxWidth: .infinity)
                    //.background(Color.gray.opacity(0.2))
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
    }
}

#Preview {
    BasketView()
        .environmentObject(ShopRecycle())
}
