//
//  MainView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 21.01.2024.
//

import SwiftUI

struct MainView: View {
    
    @State private var selection: Tab = .login
    //@State private var logged = false
    @AppStorage("onboarding") var isLogged = false
    
    var body: some View {
        //@EnvironmentObject var viewModel: YourViewModel
        if(isLogged){
            TabView(selection: $selection){
                HomePageView()
                    .environmentObject(HomePageVM())
                    .tabItem {
                        Label("Home", systemImage: "homekit")
                    }
                    .tag(Tab.main)
                
                CatalogView()
                    .tabItem {
                        Label("Catalog", systemImage: "square.grid.2x2")
                    }
                    .tag(Tab.catalog)
                
                BasketView()
                    .tabItem {
                        Label("Basket", systemImage: "basket")
                    }
                    .tag(Tab.basket)
                
                //CabinetView(isLogged: $logged)
                CabinetView()
                    .tabItem {
                        Label("Cabinet", systemImage: "gearshape")
                    }
                    .tag(Tab.cabinet)
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
