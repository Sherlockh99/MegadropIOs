//
//  MyOrdersView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 12.02.2024.
//

import SwiftUI

struct MyOrdersView: View {
    @ObservedObject private var viewModelMyOrdersManager = MyOrdersViewModel.sharedMyOrdersManager
    @EnvironmentObject var shopSettings: ShopSettings
    
    var body: some View {
        ZStack{
            VStack{
                NavigationBarDetailView()
                Text("Мої замовлення")
                Spacer()
                if !viewModelMyOrdersManager.isLoadingMyOrdersManager{
                    ScrollView(.vertical, showsIndicators: false){
                        ForEach(orders,id: \.self){
                            key in
                                MyOrderView(myOrder: key)
                        } //END: ForEach
                    } //END: ScrollView
                }
            }
        }
        .onAppear{
            viewModelMyOrdersManager.loadMyOrders()
        }
    }
}

#Preview {
    MyOrdersView()
        .environmentObject(ShopSettings())
}
