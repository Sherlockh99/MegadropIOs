//
//  HomePageNomenclature.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 28.01.2024.
//

import SwiftUI

struct HomePageNomenclature: View {
    var nomenclature: Nomenclature
    var image: Image{
        Image("logo")
    }
    var body: some View {
        VStack{
            VStack{
                image
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 155,height: 155)
            }
            
            VStack{
                Text(nomenclature.Nomenklature)
                HStack{
                    Text("Доступность:")
                    if nomenclature.Available {
                        Text("Да")
                    } else {
                        Text("Нет")
                    }
                }
            }
            Spacer()
        }
        .frame(width: 155, height: 250)
        .padding(.leading, 15)
    }
}

#Preview {
    HomePageNomenclature(nomenclature: ModelData().groupsWithNomenclatures[0].Nomenclatures[0])
}
