//
//  MainView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 21.01.2024.
//

import SwiftUI

struct MainView: View {
    @State private var selection: Tab = .login
    @State private var logged = false
    
    var body: some View {
        @EnvironmentObject var viewModel: YourViewModel
        //if(selection == .login){
        if(logged){
        //    MainLoginView(selection: $selection)
        //} else {
            TabView(selection: $selection){
                HomePageView()
                    .environmentObject(HomePageVM())
                    .tabItem {
                        //Label("Home", systemImage: "star")
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
                
                CabinetView(isLogged: $logged)
                    .tabItem {
                        Label("Cabinet", systemImage: "gearshape")
                    }
                    .tag(Tab.cabinet)
            }
        }else{
            MainLoginView(isLogged: $logged)
        }
    }
}

#Preview {
    MainView()
}
