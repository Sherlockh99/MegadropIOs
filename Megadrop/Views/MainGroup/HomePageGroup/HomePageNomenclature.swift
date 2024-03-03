//
//  HomePageNomenclature.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 28.01.2024.
//

import SwiftUI

struct HomePageNomenclature: View {
    @State var nomenclature: Nomenclature2
    var image: Image{
        Image("logo")
    }
    var body: some View {
            VStack{
                VStack{
                    if(nomenclature.Image != ""){
                        ImageViewer(imageModel: ImageModel(imageDataString: nomenclature.Image!))
                    }else{
                        image
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 150,height: 150)
                    }
 
                }
                
                VStack{
                    Text(nomenclature.Nomenclature)
                    HStack{
                        Text("Доступность:")
                        Spacer()
                        if nomenclature.Available {
                            Text("Да")
                        } else {
                            Text("Нет")
                        }
                    }
                    HStack{
                        Text("Цена:")
                        Spacer()
                        //Text("Цена: \(nomenclature.Price, specifier: "%.2f")")
                        Text(String(nomenclature.Price))
                    }
                    
                }
                Spacer()
        }
        .frame(width: 150, height: 250)
        .padding(.leading, 15)
        .onAppear{
            if(nomenclature.Image == ""){
                getPicturesNomenclature(nom1: nomenclature) {
                   modified in
                   nomenclature.Image = modified.Image
                }
            }
        }
    }
}

#Preview {
    HomePageNomenclature(nomenclature: ModelData().groupsWithNomenclatures[0].Nomenclatures[3])
}
