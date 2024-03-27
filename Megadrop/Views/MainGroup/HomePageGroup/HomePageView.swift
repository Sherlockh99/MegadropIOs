//
//  HomePageView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 27.01.2024.
//

import SwiftUI

struct HomePageView: View {
    
    // MARK: - PROPERTY
    
    @EnvironmentObject var shop: Shop
    @EnvironmentObject var vm: HomePageVM
    @StateObject var loader = DataLoader()
    
    var body: some View {
        ZStack{
            if shop.showingNomenclature == false && shop.selectedNomenclature == nil {
                VStack{
                    NavigationBarView()
                        .padding(.horizontal, 15)
                        .padding(.bottom)
                        .background(Color.white)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
                    
                    NavigationSplitView{
                        ScrollView(.vertical, showsIndicators: false){
                            ForEach(loader.dataList,id: \.self){key in
                                HomePageGroup(groupWithNomenclatures: key)
                            }
                            .onAppear() {
                                loader.loadData()
                            }
                        }
                    } detail: {
                        Text("Select a Landmark")
                    }
                }
            } else {
                //ProductDetailView()
                NomenclatureView()
            }
        }
    }
}

#Preview {
    HomePageView()
        .environmentObject(Shop())
}
