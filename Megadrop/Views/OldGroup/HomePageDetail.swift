//
//  HomePageNomenclatureItem.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 27.01.2024.
//

import SwiftUI

struct HomePageDetail: View {
    var groupWithNomenclature: GroupWithNomenclatures
    
    var body: some View {
        VStack(alignment: .leading){
            Text(groupWithNomenclature.NameGroup)
        }
    }
}

#Preview {
    HomePageDetail(groupWithNomenclature: ModelData().groupsWithNomenclatures[0])
}
