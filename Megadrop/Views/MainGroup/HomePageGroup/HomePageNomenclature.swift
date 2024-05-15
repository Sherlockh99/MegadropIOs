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
    @State var isLoaded = false
    
    var image: Image{
        Image("logo")
    }
    
    var body: some View {
        VStack{
            
            VStack{
                if(isLoaded){
                    if(nomenclature.Image != ""){
                        ImageViewer(imageModel: ImageModel(imageDataString: nomenclature.Image!))
                    }
                }
                /*
                if(nomenclature.Image != ""){
                    //ImageViewer(imageModel: ImageModel(imageDataString: nomenclature.Image!))
                }else{
                    //image
                    //    .renderingMode(.original)
                    //    .resizable()
                    //    .frame(width: 150,height: 150)
                }
                 */
            }
            
            VStack{
                //Text(nomenclature.Nomenclature)
                
                HStack{
                    Text("Доступность:")
                    Spacer()
                    /*
                     if nomenclature.Available {
                     Text("Да")
                     } else {
                     Text("Нет")
                     }
                     */
                }
                
                
                HStack{
                    Text("Цена:")
                    //Spacer()
                    //Text(String(nomenclature.Price))
                }
            }
            Spacer()
        }
        .frame(width: 150, height: 250)
        .padding(.leading, 15)
        .onAppear{
            print(nomenclature.id)
            print(nomenclature.Price)
            //TODO
            
            if(nomenclature.Image == ""){
                // Выполнение кода после отображения представления
                DispatchQueue.main.async {
                    getPicturesNomenclature(nom1: nomenclature) {
                        modified in
                        if let im = modified.Image{
                            nomenclature.Image = im
                            
                            GroupManager.shared.updateImageNomenclature(groupID: IDGroup, nomenclatureID: nomenclature.IDNomenclature, newImage: im)
                            
                        }
                    }
                    isLoaded = true
                }
                
            }else{
                isLoaded = true
            }
        }
    }
}


#Preview {
    //HomePageNomenclature(
    //    IDGroup: ModelData().groupsWithNomenclatures[0].IDGroup,
    //    nomenclature: ModelData().groupsWithNomenclatures[0].Nomenclatures![2])
    HomePageNomenclature(
        IDGroup: ModelData().groupsWithNomenclatures[0].IDGroup,
        nomenclature: ModelData().groupsWithNomenclatures[0].Nomenclatures![2])

}
