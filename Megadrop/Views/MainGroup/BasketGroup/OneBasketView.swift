//
//  OneBasketView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 27.04.2024.
//

import SwiftUI

struct OneBasketView: View {
    let IDGroup: String
    let IDNomenclature: String
    let IDCharacteristic: Int
    @State var nomenclature: Nomenclature2
    @State var characteristic: Characteristicses
    @State private var counter: Int = 0
    
    var image: Image{
        Image("logo")
    }
    
    
    var body: some View {
        HStack(alignment: .top)	{
            VStack{
                if nomenclature.Image != "" {
                    ImageViewer(imageModel: ImageModel(imageDataString: nomenclature.Image!))
                }else{
                    image
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 150,height: 200)
                }
            }
            
            VStack{
                HStack{
                    VStack{
                        Text(nomenclature.Nomenclature + "; " + characteristic.Characteristic)
                            .font(.title2)
                            .fontWeight(.black)
                    }
                    VStack{
                        Button(action: {
                            
                            //changeCounter(counter_: -1)
                            
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
        }
    }

    private func changeCounter(counter_: Int){
        
        updateQualityInServer(groupID: IDGroup, nomenclatureID: IDNomenclature, characteristicID: IDCharacteristic, count: counter_){
            modified in
            if let basketReply = modified{
                
                counter = basketReply.Count
                
                GroupManager.shared.setQualityAndPriceCharacteristic(groupID: IDGroup, nomenclatureID: IDNomenclature, characteristicID: IDCharacteristic, orderedQuality: counter, price: basketReply.Price)
                
                
            }
        }
    }
    
}

#Preview {
    OneBasketView(
        IDGroup: ModelData().groupsWithNomenclatures[0].IDGroup,
        IDNomenclature: ModelData().groupsWithNomenclatures[0].Nomenclatures![2].IDNomenclature, IDCharacteristic: ModelData().groupsWithNomenclatures[0].Nomenclatures![2].Characteristics?[0].IDCharacteristic ?? 0,
        nomenclature: ModelData().groupsWithNomenclatures[0].Nomenclatures![2],
        characteristic: (ModelData().groupsWithNomenclatures[0].Nomenclatures![2].Characteristics?[0])!)
}
