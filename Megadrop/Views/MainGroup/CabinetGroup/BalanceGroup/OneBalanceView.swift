//
//  OneBalanceView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 31.07.2024.
//

import SwiftUI

struct OneBalanceView: View {
    let mySale: SaleXDTO
    var body: some View {
        LazyVStack{
            
            HStack{
                Text(mySale.Link)
            Spacer()
            }
            
            HStack{
                Text("Клієнт: " + mySale.Contractor)
                Spacer()
            }
            
            HStack{
                Text("Вартість товару: " + String(mySale.AmountDocument) + " грн. ")
                Spacer()
            }

            let typeOfPayment = mySale.TypeOfPayment
            HStack{
                if typeOfPayment == 1 {
                    Text("Сума Нова Пошта: " + String(mySale.AmountNovaPoshta) + " грн. ")
                }else if typeOfPayment == 2 {
                    Text("Предоплата по картці: " + String(mySale.AmountDocument) + " грн. ")
                }else if typeOfPayment == 3 {
                    Text("Оплата з балансу: " + String(mySale.AmountDocument) + " грн. ")
                }
                Spacer()
            }
            Rectangle()
                .frame(height: 2) // Установка высоты для горизонтальной линии
                .foregroundColor(.black) // Установка цвета
        }
    }
}

#Preview {
    OneBalanceView(
        mySale: ModelData().balanceModelData[0])
}
