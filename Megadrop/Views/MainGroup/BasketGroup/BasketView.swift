//
//  BasketView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 27.01.2024.
//

import SwiftUI

struct BasketView: View {
    @ObservedObject private var viewModelBasketManager = BasketManager.sharedBasketManager
    
    var body: some View {
        VStack{
            ScrollView(.vertical, showsIndicators: false){
                if !viewModelBasketManager.isLoadingBasketManager{
                    ForEach(basket,id: \.self){
                        key in
                        
                        //Text(key.IDCharacteristic)
                        OneBasketView(basketOrder: key)
                    }
                }
            }
            .onAppear{
                viewModelBasketManager.loadBasket()
            }
        }
    }
}

#Preview {
    BasketView()
}
