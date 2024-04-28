//
//  HomePageGroups.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 27.01.2024.
//

import SwiftUI

struct HomePageRow: View {
    var item: GroupWithNomenclatures
    
    var body: some View {
        HStack{
            Text(item.Nomenclatures?[0].Nomenclature ?? "Empty")
        }
    }
}

#Preview {
    let groupsWithNomenclatures = ModelData().groupsWithNomenclatures
    //return HomePageRow(item: groupsWithNomenclatures[0])
    return Group{
        HomePageRow(item: groupsWithNomenclatures[0])
        HomePageRow(item: groupsWithNomenclatures[1])
    }
}
