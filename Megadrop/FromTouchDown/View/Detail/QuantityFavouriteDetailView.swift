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
    @EnvironmentObject var shop: Shop
    @State private var counter: Int = 0
    @State private var characteristic: Characteristicses?

    // MARK: - BODY
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 6, content: {
            Text(characteristic?.Characteristic ?? "Characteristic")
                .font(.system(.body, design: .rounded))
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
            
        })
        .font(.system(.title, design: .rounded))
        .foregroundColor(.black)
        .imageScale(.large)
        .onAppear{
            characteristic = GroupManager.shared.getCharacteristic(
                groupID: IDGroup,
                nomenclatureID: IDNomenclature,
                characteristicID: IDCharacteristic)
            counter = characteristic?.OrderedQuality ?? 0
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
    QuantityFavouriteDetailView(
        IDGroup: ModelData().groupsWithNomenclatures[0].IDGroup,
        IDNomenclature: ModelData().groupsWithNomenclatures[0].Nomenclatures![2].IDNomenclature,
        IDCharacteristic: ModelData().groupsWithNomenclatures[0].Nomenclatures![2].Characteristics![0].IDCharacteristic)
}

