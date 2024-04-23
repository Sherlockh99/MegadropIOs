//
//  HomePageNomenclature.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 28.01.2024.
//

import SwiftUI

struct HomePageNomenclature: View {
    
    let IDGroup: String
    @State var nomenclature: Nomenclature2

    
    var image: Image{
        Image("logo")
    }
    var body: some View {
        VStack{
            
            VStack{
                /*
                if viewModel.isPictureLoaded{
                    if nomenclature.Image != nil {
                        ImageViewer(imageModel: ImageModel(imageDataString: nomenclature.Image!))
                    }else{
                        image
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 150,height: 150)
                    }
                }else{
                    image
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 150,height: 150)
                }
                */
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
                    Text(String(nomenclature.Price))
                }
                
            }
            Spacer()
        }
        .frame(width: 150, height: 250)
        .padding(.leading, 15)
        .onAppear{
            //TODO
            
            if(nomenclature.Image == ""){
                /*
                 GroupManager.shared.getPicturesNomenclature(IDGroup: IDGroup, IDNomenclature: nomenclature.IDNomenclature)
                 */
                
                getPicturesNomenclature(nom1: nomenclature) {
                    modified in
                    if let im = modified.Image{
                        nomenclature.Image = im
                        
                        GroupManager.shared.updateImageNomenclature(groupID: IDGroup, nomenclatureID: nomenclature.IDNomenclature, newImage: im)
                    
                    }

                }
                
            }
        }
        
    }
}


#Preview {
    HomePageNomenclature(
        IDGroup: ModelData().groupsWithNomenclatures[0].IDGroup,
        nomenclature: ModelData().groupsWithNomenclatures[0].Nomenclatures[2])
}
