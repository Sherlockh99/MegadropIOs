//
//  MainView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 21.01.2024.
//

import SwiftUI

struct MainView: View {
    
    @State private var selection: Tab = .login
    @AppStorage("onboarding") var isLogged = true
    
    var body: some View {
        if(isLogged){
            ZStack{
                TabView(selection: $selection){
                    HomePageView()
                        .environmentObject(Shop())
                        .tabItem {
                            Label("Home", systemImage: "homekit")
                        }
                        .tag(Tab.main)
                    
                    CatalogView()
                        .environmentObject(Shop())
                        .tabItem {
                            Label("Catalog", systemImage: "square.grid.2x2")
                        }
                        .tag(Tab.catalog)
                    
                    BasketView()
                        .environmentObject(ShopRecycle())
                        .tabItem {
                            Label("Basket", systemImage: "basket")
                        }
                        .tag(Tab.basket)
                    
                    CabinetView()
                        .tabItem {
                            Label("Cabinet", systemImage: "gearshape")
                        }
                        .tag(Tab.cabinet)
                }
            }
       }else{
            MainLoginView()
       }
    }
}

#Preview {
    MainView()
        .environmentObject(Shop())
}
