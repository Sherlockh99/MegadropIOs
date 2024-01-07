//
//  HomePageListNomenclature.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 28.01.2024.
//

import SwiftUI

struct HomePageListNomenclature: View {
    var nomenclatures: [Nomenclature]
    
    var body: some View {
        VStack(alignment: .leading){            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(alignment: .top, spacing: 0){
                    ForEach(nomenclatures){ nom in
                        //Text(nom.IDNomenclature)
                        HomePageNomenclature(nomenclature: nom)
                    }
                }
            }
        }
    }
}

#Preview {
    let groupWithNomenclatures = ModelData().groupsWithNomenclatures[0]
    return HomePageListNomenclature(
        nomenclatures: Array(groupWithNomenclatures.Nomenclatures))
}
