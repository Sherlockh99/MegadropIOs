//
//  MainView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 21.01.2024.
//

import SwiftUI

struct MainView: View {
    @State private var selection: Tab = .main
    
    enum Tab {
        case main
        case catalog
        case basket
        case cabinet
    }
    
    var body: some View {
        TabView(selection: $selection){
            HomePageView()
                .tabItem {
                    Label("Home", systemImage: "star")
                }
                .tag(Tab.main)
            CatalogView()
                .tabItem {
                    Label("Catalog", systemImage: "")
                }
                .tag(Tab.catalog)
            BasketView()
                .tabItem {
                    Label("Basket", systemImage: "basket")
                }
                .tag(Tab.basket)
            CabinetView()
                .tabItem {
                    Label("Cabinet", systemImage: "cabinet")
                }
                .tag(Tab.cabinet)
        }
    }
}

#Preview {
    MainView()
}
