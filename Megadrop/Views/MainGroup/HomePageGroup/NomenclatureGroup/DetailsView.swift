//
//  DetailsView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 16.05.2024.
//

import SwiftUI

struct DetailsView: View {
    let IDGroup: String
    @State var nom3: Nomenclature2
    @EnvironmentObject var shop: Shop
    @StateObject private var nomenclatureFullDataLoaderSNDFL = NomenclatureFullDataLoader.sharedNFDL
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 0, content: {
            ScrollView(.vertical, showsIndicators: false, content: {
                if let details3 = nom3.Details {
                    Text(details3)
                        .font(.system(.body, design: .rounded))
                        .multilineTextAlignment(.leading)
                }
                else {
                    Text(shop.selectedNomenclature?.Nomenclature ?? sampleProduct.description)
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                }

                
                Spacer()
                
                //if let nom2 = nomenclatureFullDataLoader.nomenclature2{
                //if let nom2 = nomenclature{
                //if !viewModelNFDL.isLoadedNDFL{
                    if let characteristics = nom3.Characteristics{
                        ForEach(characteristics,id: \.self){key in
                            QuantityFavouriteDetailView(
                                IDGroup: IDGroup,
                                IDNomenclature: nom3.IDNomenclature,
                                IDCharacteristic: key.IDCharacteristic)
                        }
                    }
                //}
                //}
                
            })//: SCROLL
        })//: VSTACK
        .padding(.horizontal)
        .padding(.bottom,105)
        .onAppear{
            //if let selectedNomenclature = shop.selectedNomenclature {
                //nomenclatureFullDataLoaderSNDFL.loadFullNomenclatureData(groupID: IDGroup, idNomenclature: selectedNomenclature.IDNomenclature)
            if let detailsNom = nom3.Details {
                
            }else{
                getDataNomenclature(nomenclature: nom3) {
                    modified in
                    nom3 = modified
                    GroupManager.shared.updateFullDataNomenclature(groupID: IDGroup, nomenclatureID: nom3.IDNomenclature, nom2: modified)
                }
            }
        }
    }
}

#Preview {
    DetailsView(IDGroup: ModelData().groupsWithNomenclatures[0].IDGroup,
                nom3: ModelData().groupsWithNomenclatures[0].Nomenclatures![0])
        .environmentObject(Shop())
}
