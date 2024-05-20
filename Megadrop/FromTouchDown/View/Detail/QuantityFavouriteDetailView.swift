//
//  QuantityFavouriteDetailView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 16.03.2024.
//

import SwiftUI

struct QuantityFavouriteDetailView: View {
    let IDGroup: String
    let IDNomenclature: String
    let IDCharacteristic: Int
        
    // MARK: - PROPERTY
    //@EnvironmentObject var shop: Shop
    @State private var counter: Int = 0
    @State private var price: Double = 0
    @State private var sumOrder: Double = 0

    @State private var characteristic: Characteristicses?

    // MARK: - BODY
    
    var body: some View {
        HStack{
            HStack{
                Text(characteristic?.Characteristic ?? "Characteristic")
                    .font(.system(.body, design: .rounded))
            }
            
            Spacer()
            
            VStack{
                HStack{
                    Spacer()
                    Text("Цена: ")
                    //Spacer()
                    Text(String(characteristic?.Price ?? 0.00))
                }
                .font(.system(.body, design: .rounded))
                
                //HStack(alignment: .center, spacing: 6, content: {
                HStack{
                    Spacer()
                    Text("Количество:")
                }
                HStack{
                    //Spacer()
                    
                    Spacer()
                    Button(action: {
                        
                        changeCounter(counter_: -1)
                        
                        if counter > 0 {
                            feedback.impactOccurred()
                            changeCounter(counter_: -1)
                        }
                        
                    }, label: {
                        Image(systemName: "minus.circle")
                    })
                    
                    Text("\(counter)")
                        .fontWeight(.semibold)
                        .frame(minWidth: 36)
                    
                    
                    Button(action: {
                        if counter < 100 {
                            feedback.impactOccurred()
                            changeCounter(counter_: 1)
                        }
                    }, label: {
                        Image(systemName: "plus.circle")
                    })
                }
                
                HStack{
                    Spacer()
                    Text("Сумма: ")
                    //Spacer()
                    Text(String(sumOrder))
                }
            }
            .font(.system(.body, design: .rounded))
            //})
 
        }
        .font(.system(.title, design: .rounded))
        .foregroundColor(.black)
        .imageScale(.large)
        .onAppear{
            
            characteristic = GroupManager.shared.getCharacteristic(
                groupID: IDGroup,
                nomenclatureID: IDNomenclature,
                characteristicID: IDCharacteristic)
             
            counter = characteristic?.OrderedQuality ?? 0
            price = characteristic?.Price ?? 0.0
            sumOrder = Double(counter) * price
        }
    }
    
    private func changeCounter(counter_: Int){
        
        updateQualityInServer(groupID: IDGroup, nomenclatureID: IDNomenclature, characteristicID: IDCharacteristic, count: counter_){
            modified in
            if let basketReply = modified{
                
                counter = basketReply.Count
                characteristic?.Price = basketReply.Price
                price = characteristic?.Price ?? 0.0
                sumOrder = Double(counter) * price
                
                GroupManager.shared.setQualityAndPriceCharacteristic(groupID: IDGroup, nomenclatureID: IDNomenclature, characteristicID: IDCharacteristic, orderedQuality: counter, price: basketReply.Price)
                              
            }
        }
         
    }
         
}


#Preview {
    QuantityFavouriteDetailView(
        IDGroup: ModelData().groupsWithNomenclatures[0].IDGroup,
        IDNomenclature: ModelData().groupsWithNomenclatures[0].Nomenclatures![2].IDNomenclature,
        IDCharacteristic: 2)
}

