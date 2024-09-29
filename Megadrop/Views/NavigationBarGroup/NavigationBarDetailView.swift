//
//  NavigationBarDetailView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 16.03.2024.
//

import SwiftUI

struct NavigationBarDetailView: View {
    
    // MARK: - PROPERTY
    
    @EnvironmentObject var shop: Shop
    @EnvironmentObject var shopRecycle: ShopRecycle
    @EnvironmentObject var shopSettings: ShopSettings

    
    @State private var isAnimated: Bool = false
    // MARK: - BODY
    var body: some View {
        HStack {
            Button(action: {
                withAnimation(.easeIn){
                    feedback.impactOccurred()
                    if shop.isNomenclatureCatalog {
                        shop.isNomenclatureCatalog = false
                        shop.selectedNomenclatureCatalog = nil
                        shop.isGroupCatalog = true
                    }else if !shopRecycle.isNomenclatureRecycle && shopRecycle.selectedNomenclatureRecycle != nil{
                        shopRecycle.isNomenclatureRecycle = true
                    }else if shopRecycle.isBuy {
                        shopRecycle.isNomenclatureRecycle = true
                        shopRecycle.isBuy = false
                    } else if shopSettings.isMyOrders {
                        shopSettings.isMyOrders = false
                        shopSettings.isMain = true
                    } else if shopSettings.isBalance {
                        shopSettings.isBalance = false
                        shopSettings.isMain = true
                    } else if shopSettings.isAbout {
                        shopSettings.isAbout = false
                        shopSettings.isSettings = true
                    } else if shopSettings.isSettings {
                        shopSettings.isSettings = false
                        shopSettings.isMain = true
                    } else {
                        shop.selectedProduct = nil
                        shop.showingProduct = false
                        shop.selectedNomenclature = nil
                        shop.showingNomenclature = false
                    }
                }
            }, label: {
                Image(systemName: "chevron.left")
                    .font(.title)
                    //.foregroundColor(.white)
            })
            
            Spacer()
            
            LogoView()
              .opacity(isAnimated ? 1 : 0)
              .offset(x: 0, y: isAnimated ? 0 : -25)
              .onAppear(perform: {
                withAnimation(.easeOut(duration: 0.5)) {
                  isAnimated.toggle()
                }
              })
            
            Spacer()
            /*
            Button(action:{},label: {
                Image(systemName: "cart")
                    .font(.title)
                    .foregroundColor(.white)
            })
             */
        } //: HSTACK
    }
}

#Preview {
    NavigationBarDetailView()
        .environmentObject(Shop())
        .previewLayout(.sizeThatFits)
        .padding()
        //.background(Color.gray)
}
