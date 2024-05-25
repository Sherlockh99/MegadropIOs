//
//  GroupCatalogView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 25.05.2024.
//

import SwiftUI

struct GroupCatalogView: View {
    @EnvironmentObject var shop: Shop
    @State private var feedback = UIImpactFeedbackGenerator(style: .medium)
    
    let columns = [
           GridItem(.flexible()),
           GridItem(.flexible())
       ]
    	
    var body: some View {
        VStack{
            if let nom4 = GroupManager.shared.getNomenclatures(groupID: shop.idGroupCatalog) {
                NavigationBarSearchListNomenclatureView()
                    .background(Color.gray)
                
                SearchView()
                
                ScrollView{
                    LazyVGrid(columns: columns, spacing: 10){
                        ForEach(nom4, id: \.self){ key in
                            HomePageNomenclature(IDGroup: shop.idGroupCatalog, nomenclature: key)
                                .frame(maxWidth: .infinity)
                                //.background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                                .padding(5)
                                .onTapGesture {
                                    feedback.impactOccurred()
                                    
                                    withAnimation(.easeOut) {
                                        shop.selectedNomenclatureCatalog = key
                                        shop.isGroupCatalog = false
                                        shop.isNomenclatureCatalog = true
                                    }
                                }
                        } //END: FOR EACH
                    } //END: LAZYVGRID
                    .padding(.horizontal, 5)
                } //END: SCROLLVIEW
            }
        }
        //END: VSTACK
    }
}

#Preview {
    GroupCatalogView()
        .environmentObject(Shop())
}
