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
    @State var characteristic: Characteristicses?
    @State private var counter: Int = 0
    @State var isLoaded = false
    
    var image: Image{
        Image("logo")
    }
    
    
    var body: some View {
        HStack(alignment: .top)	{
            VStack{
                if let nom = nomenclature {
                    if nom.Image != "" {
                        ImageViewer(imageModel: ImageModel(imageDataString: nom.Image!))
                    }else{
                        image
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 150,height: 200)
                    }
                }
            }
            
            /*
            VStack{
                HStack{
                    VStack{
                        if let nom = nomenclature, let char_ = characteristic{
                            Text(nom.Nomenclature + "; " + char_.Characteristic)
                                .font(.title3)
                                .fontWeight(.black)
                        }
                    }
                    VStack{
                        Button(action: {

                            if counter > 999 {
                                feedback.impactOccurred()
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
                                feedback.impactOccurred()
                                changeCounter(counter_: -1)
                             }
                             
                        }, label: {
                            Image(systemName: "minus.circle")
                        })
                        
                    }
                    .font(.system(.title, design: .rounded))
                }
                HStack(){
                    Text("Count:")
                    Spacer()
                }
            }
            */
            
        }
        .onAppear{
            //let groupID = GroupManager.shared.getGroup(groupID: basketOrder.IDGroup)
            nomenclature = GroupManager.shared.getNomenclature(groupID: basketOrder.IDGroup, nomenclatureID: basketOrder.IDNomenclature)
            if let nom = nomenclature {
                if(nom.Image == ""){
                    // Выполнение кода после отображения представления
                    
                    DispatchQueue.main.async {
                        getPicturesNomenclature(nom1: nom) {
                            modified in
                            if let im = modified.Image{
                                nomenclature?.Image = im
                            }
                        }
                    }
                    isLoaded = true
                }
            }else{
                isLoaded = true
            }

            characteristic = GroupManager.shared.getCharacteristic(groupID: basketOrder.IDGroup, nomenclatureID: basketOrder.IDNomenclature, characteristicID: basketOrder.IDCharacteristic)
        }
    }

    private func changeCounter(counter_: Int){
      /*
        updateQualityInServer(groupID: IDGroup, nomenclatureID: nomenclature.IDNomenclature, characteristicID: characteristic.IDCharacteristic, count: counter_){
            modified in
            if let basketReply = modified{
                
                counter = basketReply.Count
                
                GroupManager.shared.setQualityAndPriceCharacteristic(groupID: IDGroup, nomenclatureID: nomenclature.IDNomenclature, characteristicID: characteristic.IDCharacteristic, orderedQuality: counter, price: basketReply.Price)
                
            }
        }
        */
    }
    
}

#Preview {
    OneBasketView(
        basketOrder: ModelData().basketModelData[0])
    /*
        IDGroup: ModelData().groupsWithNomenclatures[0].IDGroup,
        nomenclature: ModelData().groupsWithNomenclatures[0].Nomenclatures![2],
        characteristic: (ModelData().groupsWithNomenclatures[0].Nomenclatures![2].Characteristics![0]))
     */
}
