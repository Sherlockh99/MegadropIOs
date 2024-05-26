//
//  HomePageListNomenclature.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 28.01.2024.
//

import SwiftUI

struct HomePageListNomenclature: View {
    
    @EnvironmentObject var shop: Shop
    let groupsWithNomenclatures_: GroupWithNomenclatures
    
    var body: some View {
        VStack(alignment: .leading){
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack{
                    if let nomenclatures = groupsWithNomenclatures_.Nomenclatures {
                        ForEach(nomenclatures,id: \.self){
                            key in
                            //HomePageNomenclature(nomenclature: key)
                            
                             HomePageNomenclature(
                                    IDGroup: groupsWithNomenclatures_.IDGroup,
                                    nomenclature: key)                             
                                .onTapGesture {
                                  feedback.impactOccurred()
                                  
                                  withAnimation(.easeOut) {
                                      shop.IDGroup = groupsWithNomenclatures_.IDGroup
                                      shop.selectedNomenclature = key
                                      shop.showingNomenclature = true
                                  }
                                }
                        }
                    } else {
                        Text("1")
                    }
                } //: LAZYHSTACK
            } //: SCROLL
        }//: VSTACK
    }//: BODY
}

#Preview {
    let groupWithNomenclatures = ModelData().groupsWithNomenclatures[0]
    return HomePageListNomenclature(
        groupsWithNomenclatures_: groupWithNomenclatures)
}
