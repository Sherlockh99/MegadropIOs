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
        Section(header: Text(groupWithNomenclatures.NameGroup)){
            
            HomePageListNomenclature(nomenclatures: groupWithNomenclatures.Nomenclatures)
        }
        .font(.headline)
        .padding(.leading, 15)
        .padding(.top, 5)
        .foregroundColor(.primary)

    }
}

#Preview {
    HomePageGroup(groupWithNomenclatures: ModelData().groupsWithNomenclatures[0])
}
