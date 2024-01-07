//
//  HomePageGroup.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 28.01.2024.
//

import SwiftUI

struct HomePageGroup: View {
    var groupWithNomenclatures: GroupWithNomenclatures
    
    var body: some View {
        Text(groupWithNomenclatures.NameGroup)
            .font(.headline)
            .padding(.leading, 15)
            .padding(.top, 5)
        
        HomePageListNomenclature(nomenclatures: groupWithNomenclatures.Nomenclatures)
    }
}

#Preview {
    HomePageGroup(groupWithNomenclatures: ModelData().groupsWithNomenclatures[0])
}
