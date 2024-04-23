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
    @ObservedObject private var viewModel = GroupManager.shared

    
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
                            if !viewModel.isLoading{
                                
                                ForEach(groupWithNomenclatures,id: \.self){
                                    key in
                                    HomePageGroup(groupWithNomenclatures: key)
                                }
                            }
                        }
                        .onAppear() {
                            if groupWithNomenclatures.count==0 {
                                GroupManager.shared.loadGroupWithNomenclatures()
                            }

                        }
                    } detail: {
                        Text("Select a Landmark")
                    }
                }
            } else {
                NomenclatureView(IDGroup: shop.IDGroup)
            }
        }
    }
}

#Preview {
    HomePageView()
        .environmentObject(Shop())
}
