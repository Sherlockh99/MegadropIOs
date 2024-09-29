//
//  BalanceView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 12.02.2024.
//

import SwiftUI

struct BalanceView: View {
    @ObservedObject private var balanceViewModel = BalanceViewModel.sharedBalanceViewModel
    
    var body: some View {
        VStack{
            NavigationBarDetailView()
            Text(Profile.profileShared.nickname)
            if !balanceViewModel.isLoadingBalanceSum{
                Text(String(balanceSum[0].AmountDocument))
            }
            /*
            Button{
                
            } label: {
                HStack{
                    Spacer()
                    Text("Імпорт")
                    Spacer()
                }
            }
            */
            Rectangle()
                .frame(height: 3) // Установка высоты для горизонтальной линии
                .foregroundColor(.black) // Установка цвета
            Spacer()
            
            if !balanceViewModel.isLoadingBalance{
                ScrollView(.vertical, showsIndicators: false){
                    ForEach(balances_,id: \.self){
                        key in
                        OneBalanceView(mySale: key)
                    }
                }
                .font(.system(size: 14))
            }
        }
        .onAppear{
            balanceViewModel.loadBalanceAll()
        }
    }
}

#Preview {
    BalanceView()
}
