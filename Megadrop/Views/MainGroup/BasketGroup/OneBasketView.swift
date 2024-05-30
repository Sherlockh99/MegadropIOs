//
//  OneBasketView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 27.04.2024.
//

import SwiftUI

struct OneBasketView: View {
    let basketOrder: Basket
    @State var nomenclature: Nomenclature2?
    @State private var counter: Int = 0
    @State var isLoaded = false
    @State var descrNomenclature: String = ""
    
    var image: Image{
        Image("logo")
    }
    
    
    var body: some View {
        HStack(alignment: .top)	{
            
            if let nom = nomenclature {
                VStack{
                    
                    if nom.Image != "" {
                        ImageViewer(imageModel: ImageModel(imageDataString: nom.Image!))
                    }else{
                        image
                            .renderingMode(.original)
                            .resizable()
                    }
                    
                }
                .frame(width: 75,height: 75)
            } else {
                VStack{
                    image
                        .renderingMode(.original)
                        .resizable()
                }
                .frame(width: 75,height: 75)
            } //END: IF ELSE
                
            VStack{
                Text(descrNomenclature)
                Spacer()
                HStack{
                    Spacer()
                    Text("Count: ") + Text(String(counter))
                }
            }
            
            VStack{
                Button(action: {
                    if counter < 999 {
                        //feedback.impactOccurred()
                        changeCounter(counter_: 1)
                    }
                }, label: {
                    Image(systemName: "plus.circle")
                })
                
                Text("\(counter)")
                    .fontWeight(.semibold)
                    .frame(minWidth: 36)
                
                Button(action: {
                    if counter > 0 {
                        //feedback.impactOccurred()
                        changeCounter(counter_: -1)
                    }
                }, label: {
                    Image(systemName: "minus.circle")
                })
                
            }
            .font(.system(.title, design: .rounded))
        }
        .onAppear{
            
            nomenclature = GroupManager.shared.getNomenclature(groupID: basketOrder.IDGroup, nomenclatureID: basketOrder.IDNomenclature)
            
            if let nom = nomenclature {
                
                if(nom.Image == ""){
                    // Выполнение кода после отображения представления
                    
                    DispatchQueue.main.async {
                        getPicturesNomenclature(nom1: nom) {
                            modified in
                            if let im = modified.Image{
                                nomenclature?.Image = im
                                
                                GroupManager.shared.updatePhotoNomenclature(groupID: basketOrder.IDGroup, nomenclatureID: basketOrder.IDNomenclature, Image: im)
                                 
                            }
                        }

                    }
                    isLoaded = true
                }
                
                counter = basketOrder.Count
                
                if nom.Details != nil || nom.Details != "" {
                    //counter = nom.Details.count
                }else{
                    
                    getDataNomenclature(nomenclature: nom) {
                        modified in
                        let nom3 = modified
                        GroupManager.shared.updateFullDataNomenclature(groupID: basketOrder.IDGroup, nomenclatureID: nom3.IDNomenclature, nom2: modified)
                        /*
                        GroupManager.shared.setQualityAndPriceCharacteristic(groupID: basketOrder.IDGroup, nomenclatureID: basketOrder.IDNomenclature, characteristicID: basketOrder.IDCharacteristic, orderedQuality: basketOrder.Count, price: Double(basketOrder.Price))
                         */
                        
                        GroupManager.shared.setQualityAndPriceCharacteristic(groupID: basketOrder.IDGroup, nomenclatureID: basketOrder.IDNomenclature, characteristicName: basketOrder.NameCharacteristic, orderedQuality: basketOrder.Count, price: Double(basketOrder.Price))
                        
                        //counter = basketOrder.Count
                    }
                    
                    
                }
                
            }else{
                isLoaded = true
            }
            
            descrNomenclature = basketOrder.NameNomenclaure
            if basketOrder.isCharacteristic {
                descrNomenclature = descrNomenclature + "; " + basketOrder.NameCharacteristic
            }
        }
    }

    private func changeCounter(counter_: Int){
      
//        updateQualityInServer(groupID: basketOrder.IDGroup, nomenclatureID: basketOrder.IDNomenclature, characteristicID: basketOrder.IDCharacteristic, count: counter_){
        updateQualityInServer(groupID: basketOrder.IDGroup, nomenclatureID: basketOrder.IDNomenclature, isCharacteristic: basketOrder.isCharacteristic, characteristicName: basketOrder.NameCharacteristic, count: counter_){
  
            modified in
            if let basketReply = modified{
                
                counter = basketReply.Count
                /*
                GroupManager.shared.setQualityAndPriceCharacteristic(groupID: basketOrder.IDGroup, nomenclatureID: basketOrder.IDNomenclature, characteristicID: basketOrder.IDCharacteristic, orderedQuality: counter, price: basketReply.Price)
*/
                GroupManager.shared.setQualityAndPriceCharacteristic(groupID: basketOrder.IDGroup, nomenclatureID: basketOrder.IDNomenclature, characteristicName: basketOrder.NameCharacteristic, orderedQuality: basketReply.Count, price: basketReply.Price)
            
            }
        }
        
    }
    
}

#Preview {
    OneBasketView(
        basketOrder: ModelData().basketModelData[0])
}
