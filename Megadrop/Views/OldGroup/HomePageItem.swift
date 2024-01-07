//
//  HomePageItem.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 27.01.2024.
//

import SwiftUI

struct HomePageItem: View {
    var groupWithNomenclatures: GroupWithNomenclatures
    
    var body: some View {
        VStack(alignment: .leading){
            Text(groupWithNomenclatures.NameGroup)
        }
    }
}

#Preview {
    HomePageItem(groupWithNomenclatures: ModelData().groupsWithNomenclatures[0])
}
