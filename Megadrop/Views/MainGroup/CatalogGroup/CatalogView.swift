//
//  CatalogView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 27.01.2024.
//

import SwiftUI

struct CatalogView: View {
    @State private var searchText = ""
    @State private var isSearching = false
    //@State private var isNomenclature = false
    @EnvironmentObject var shop: Shop

    let items = Array(1...30)  // Массив чисел от 1 до 30

    /*
    let columns: [GridItem] = [
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
        GridItem(.fixed(100))
    ] */
    
    let columns: [GridItem] = [
        GridItem(.fixed(100)),
        GridItem(.fixed(100))
    ]
    
    var body: some View {
        if shop.isNomenclatureCatalog {
            // DETAIL TOP PART
            if let nom3 = shop.selectedNomenclatureCatalog {
                VStack{
                    //NomenclatureView(IDGroup: shop.idGroupCatalog, nomenclature: nom3)
                    
                     NomenclatureView(IDGroup: shop.idGroupCatalog, nomenclature: nom3)
                     .onTapGesture {
                         shop.selectedNomenclature = nil
                         shop.isNomenclatureCatalog = false
                         shop.isGroupCatalog = true
                     }
                }
            }
        }
        else {
            VStack{
                //ПОИСК
                VStack{
                    
                    Text("Поиск")
                    
                    //START: TEXTFILED
                    TextField("Поиск...", text: $searchText)
                        .padding(7)
                        .padding(.horizontal, 25)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            HStack {
                                
                                Image(systemName: "")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 8)
                                
                                if !searchText.isEmpty {
                                    Button(action: {
                                        print(searchText)
                                        
                                    }) {
                                        Image(systemName: "magnifyingglass")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 8)
                                    }
                                }
                            }
                        )
                        .padding(.horizontal, 10)
                    // Добавление кнопки поиска как части тулбара
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                
                                Button("Поиск") {
                                    isSearching = true
                                    // Действие поиска
                                    //print("Поиск выполнен")
                                }
                            }
                        }
                    //END: TEXTFIELD
                    
                    if(isSearching){
                        Text("Поиск выполнен")
                    }
                    
                } //: VSTACK
                
                Spacer()
                
                ZStack{
                    if(shop.isGroupsCatalog){
                        ScrollView {
                            //LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(groupWithNomenclatures, id: \.self) { item in
                                Button("\(item.NameGroup)"){
                                    shop.isGroupsCatalog = false
                                    shop.isGroupCatalog = true
                                    shop.idGroupCatalog = item.IDGroup
                                }
                            }
                            //} //:LAZYVGRID
                            //.padding(.horizontal)
                        } //: SCROLLVIEW
                    } else if shop.isGroupCatalog {
                        VStack{
                            NavigationBarSearchListNomenclatureView()
                            if let nom4 = GroupManager.shared.getNomenclatures(groupID: shop.idGroupCatalog) {
                                
                                ScrollView{
                                    LazyVGrid(columns: columns, spacing: 10){
                                        ForEach(nom4, id: \.self){ key in
                                            HomePageNomenclature(IDGroup: shop.idGroupCatalog, nomenclature: key)
                                                .onTapGesture {
                                                    feedback.impactOccurred()
                                                    
                                                    withAnimation(.easeOut) {
                                                        //shop.IDGroup = shop.idGroupCatalog
                                                        shop.selectedNomenclatureCatalog = key
                                                        shop.isGroupCatalog = false
                                                        shop.isNomenclatureCatalog = true
                                                    }
                                                }
                                        }
                                    }
                                }
                            }
                        }
                        .background(
                            Color(
                                red: shop.selectedProduct?.red ?? sampleProduct.red,
                                green: shop.selectedProduct?.green ?? sampleProduct.green,
                                blue: shop.selectedProduct?.blue ?? sampleProduct.blue
                            ).ignoresSafeArea(.all, edges: .all)
                        )
                    } //:else if
                } //:ZStack
                
                /*
                 else if isGroup{ //isGroups
                 if let nom4 = GroupManager.shared.getNomenclatures(groupID: idGroup){
                 ScrollView {
                 LazyVGrid(columns: columns, spacing: 20) {
                 ForEach(nom4, id: \.self){ key in
                 //Text(item.Nomenclature)
                 HomePageNomenclature(
                 IDGroup: idGroup,
                 nomenclature: key)
                 .onTapGesture {
                 feedback.impactOccurred()
                 
                 withAnimation(.easeOut) {
                 shop.IDGroup = idGroup
                 shop.selectedNomenclature = key
                 shop.showingNomenclature = true
                 }
                 isNomenclature = true
                 isGroup = false
                 isGroups = false
                 }
                 }
                 }
                 }
                 .font(.headline)
                 .padding(.leading, 15)
                 .padding(.top, 5)
                 .foregroundColor(.primary)
                 }
                 }else if isNomenclature {
                 NomenclatureView(IDGroup: idGroup, nomenclature: shop.selectedNomenclature ?? ModelData().groupsWithNomenclatures[0].Nomenclatures![0])
                 }else {
                 Button("Press me"){
                 isGroup = false
                 isGroups = true
                 }
                 }//:else if isGroup
                 */
                
            } //:VStack
            .onAppear{
                if groupWithNomenclatures.count>0 && 
                    !shop.isGroupCatalog &&
                    shop.selectedNomenclatureCatalog == nil{
                    shop.isGroupsCatalog = true
                }else{
                    shop.isGroupsCatalog = false
                }
            }
            //Spacer()
        } //:else if
    } //:BODY
}

#Preview {
    CatalogView()
        .environmentObject(Shop())
}
