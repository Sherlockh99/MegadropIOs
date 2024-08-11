//
//  MyOrdersView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 12.02.2024.
//

import SwiftUI

struct MyOrdersView: View {
    @ObservedObject private var viewModelMyOrdersManager = MyOrdersViewModel.sharedMyOrdersManager
    
    var body: some View {
        ZStack{
            VStack{
                Text("Мої замовлення")
                Spacer()
                if !viewModelMyOrdersManager.isLoadingMyOrdersManager{
                    ScrollView(.vertical, showsIndicators: false){
                        ForEach(orders,id: \.self){
                            key in
                                MyOrderView(myOrder: key)
                            /*
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
                            */
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
}
