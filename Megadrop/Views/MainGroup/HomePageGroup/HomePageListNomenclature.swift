//
//  HomePageListNomenclature.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 28.01.2024.
//

import SwiftUI

struct HomePageListNomenclature: View {
    let groupsWithNomenclatures_: GroupWithNomenclatures
    var body: some View {
        VStack(alignment: .leading){
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack{
                    if let nomenclatures = groupsWithNomenclatures_.Nomenclatures {
                        ForEach(nomenclatures,id: \.self){
                            key in
                            NavigationLink(destination: NomenclatureView(IDGroup: groupsWithNomenclatures_.IDGroup)) {
                                HomePageNomenclature(
                                    IDGroup: groupsWithNomenclatures_.IDGroup,
                                    nomenclature: key)
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
