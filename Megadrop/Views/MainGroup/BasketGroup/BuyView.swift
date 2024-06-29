//
//  BuyView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 29.06.2024.
//

import SwiftUI

struct BuyView: View {
    @EnvironmentObject var shop: Shop
    var body: some View {
        VStack{
            NavigationBarDetailView()
                .padding(.horizontal)
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            
            Text("Hello, World!")
        }
        .background(
           Color(
               red: shop.selectedProduct?.red ?? sampleProduct.red,
                green: shop.selectedProduct?.green ?? sampleProduct.green,
               blue: shop.selectedProduct?.blue ?? sampleProduct.blue
           ).ignoresSafeArea(.all, edges: .all)
        )
        
    }
}

#Preview {
    BuyView()
        .environmentObject(Shop())
}
