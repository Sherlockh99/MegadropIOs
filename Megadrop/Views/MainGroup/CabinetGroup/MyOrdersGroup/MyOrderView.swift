//
//  MyOrderView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 12.02.2024.
//

import SwiftUI

struct MyOrderView: View {
    let myOrder: OrdersXDTO
    var body: some View {
        LazyVStack{
            HStack{
                Text("№ замовлення")
                    .font(.system(size: 14))
                Spacer()
                Text(myOrder.IDOrder)
                    .foregroundColor(.green)
                    .font(.system(size: 18))
            }
            HStack{
                Text("Дата замовлення")
                Spacer()
                Text(myOrder.DateOrder)
                    .bold()
            }
            HStack{
                Text("Замовник")
                Spacer()
                Text(myOrder.CounterParty)
            }
            HStack{
                Text("Номер телефону")
                Spacer()
                Text(myOrder.TelephoneNumber)
                    .foregroundColor(.blue)
                    .bold()
                    .font(.system(size: 18))
            }
            
            HStack{
                Text("ТТН замовлення")
                Spacer()
                Text(myOrder.TTN)
                    .foregroundColor(.blue)
                    .bold()
                    .font(.system(size: 18))
            }
            HStack{
                Text("Сумма замовлення")
                Spacer()
                Text(String(myOrder.SumOrder) + " грн.")
                    .font(.system(size: 20))
                    .bold()
            }
            
            HStack{
                Text("Статус")
                Spacer()
                Text(myOrder.StatusOrder)
            }
            HStack{
                Text("Тип оплати")
                Spacer()
                Text(myOrder.TypePayment)
            }
             
        }
        .font(.system(size: 14))
        .padding()
        Rectangle()
            .frame(height: 2) // Установка высоты для горизонтальной линии
            .foregroundColor(.blue) // Установка цвета
    }
}

#Preview {
    MyOrderView(
        myOrder: ModelData().ordersModelData[0])
}
