//
//  CabinetView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 27.01.2024.
//

import SwiftUI

struct CabinetView: View {
    @State private var selection: TabCabinet = .main

    //@Binding var isLogged: Bool

    enum TabCabinet {
        case main
        case catalog
        case basket
        case cabinet
        case settings
    }

    var body: some View {
        //if(selection == .settings){
        //    SettingsView(isLogged: $isLogged)
        //}else{
            NavigationSplitView{
                LogoImage(image: Image("logo"))
                Text(Profile.profileShared.nickname)
                NavigationLink{
                    MyOrdersView()
                }label: {
                    Text("Мої замовлення")
                }
                NavigationLink{
                    BalanceView()
                }label: {
                    Text("Баланс")
                }
                NavigationLink{
                    //NomenclatureView(nomenclature: nom)
                }label: {
                    Text("Получить прайс")
                }
                NavigationLink{
                    //NomenclatureView(nomenclature: nom)
                }label: {
                    Text("Взаиморасчеты")
                }
                NavigationLink{
                    //SettingsView(isLogged: $isLogged)
                    SettingsView()
                }label: {
                    Text("Настройки")
                }
                /*
                Button{
                    selection = .settings
                } label: {
                    //HStack{
                    //    Spacer()
                        Text("Настройки")
                    //    Spacer()
                    //}
                    //.font(.system(.title2, design: .rounded, weight: .bold))
                }
                 */
                Spacer()
            }detail: {
                Text("!")
            }
            .font(.system(.title, design: .rounded, weight: .bold))
        //}
    }
}

#Preview {
    CabinetView()
}
