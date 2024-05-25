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
    @ObservedObject private var viewModel = GroupManager.shared
    
    var body: some View {
        ZStack{
            if shop.showingNomenclature == false && shop.selectedNomenclature == nil {
                VStack{
                    NavigationBarHomeView()
                        .padding(.horizontal, 15)
                        .padding(.bottom)
                        .background(Color.white)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
                    
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
                            }else{
                                shop.isGroupsCatalog = true
                            }

                        }
                }
            } else {
                NomenclatureView(IDGroup: shop.IDGroup, nomenclature: shop.selectedNomenclature ?? ModelData().groupsWithNomenclatures[0].Nomenclatures![0])
            }
        }
    }
}

#Preview {
    HomePageView()
        .environmentObject(Shop())
}
