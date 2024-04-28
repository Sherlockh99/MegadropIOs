//
//  HomePageListNomenclature.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 28.01.2024.
//

import SwiftUI

struct HomePageListNomenclature: View {
    let IDGroup: String
    //@ObservedObject private var viewModel = GroupManager.shared
    
    @State var nomenclatures: [Nomenclature2]
    @EnvironmentObject var shop: Shop
    
    var body: some View {
        VStack(alignment: .leading){            
            ScrollView(.horizontal, showsIndicators: false){
                
                //LazyVGrid(columns: gridLayout, spacing: 15, content: {
                HStack(alignment: .top, spacing: 0){
                    
                    ForEach(nomenclatures) { nom in
                        
                        HomePageNomenclature(IDGroup: IDGroup, nomenclature: nom)
                            .onTapGesture {
                                feedback.impactOccurred()
                                
                                withAnimation(.easeOut) {
                                    shop.selectedNomenclature = nom
                                    shop.showingNomenclature = true
                                    shop.IDGroup = IDGroup
                                }
                         
                            }
                    
                         }
                         
                         //: LOOP
                }
                //}) //: GRID
            }
        }
    }
}

#Preview {
    let groupWithNomenclatures = ModelData().groupsWithNomenclatures[0]
    return HomePageListNomenclature(
        IDGroup: ModelData().groupsWithNomenclatures[0].IDGroup,
        nomenclatures: Array(groupWithNomenclatures.Nomenclatures ?? []))
}
