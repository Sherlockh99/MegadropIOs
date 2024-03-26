//
//  HomePageListNomenclature.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 28.01.2024.
//

import SwiftUI

struct HomePageListNomenclature: View {
    @State var nomenclatures: [Nomenclature2]
    
    var body: some View {
        VStack(alignment: .leading){            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(alignment: .top, spacing: 0){
                    ForEach(nomenclatures){ nom in
                        /*
                        Button {
                            NomenclatureView(nomenclature: nom)
                        }label: {
                            HomePageNomenclature(nomenclature: nom)
                        }
                        .buttonStyle(.plain)
                        */
                        NavigationLink{
                            //NomenclatureView(nomenclature: nom)
                            NomenclatureView()
                        }label: {
                            HomePageNomenclature(nomenclature: nom)
                        }
                        
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
