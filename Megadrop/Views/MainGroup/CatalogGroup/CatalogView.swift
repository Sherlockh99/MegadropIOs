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
    @State private var isGroups = true
    @State private var isGroup = true
    @State private var idGroup = ""
    @State private var isNomenclature = false

    @EnvironmentObject var shop: Shop
    //@ObservedObject private var viewModel = GroupManager.shared

    let items = Array(1...30)  // Массив чисел от 1 до 30
/*
    let columns: [GridItem] = [
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
        GridItem(.fixed(100))
    ]
*/
    let columns: [GridItem] = [
        GridItem(.fixed(100)),
        GridItem(.fixed(100))
    ]
    
    var body: some View {
        VStack{
            VStack{
                Text("Поиск")
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
                                    //self.searchText = ""
                                    
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
                if(isSearching){
                    Text("Поиск выполнен")
                }
            }
            Spacer()
            ZStack{
                if(isGroups){
                    ScrollView {
                        //LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(groupWithNomenclatures, id: \.self) { item in
                                Button("\(item.NameGroup)"){
                                    isGroups = false
                                    isGroup = true
                                    idGroup = item.IDGroup
                                }
                                /*
                                 Text("\(item.NameGroup)")
                                 .frame(width: 100, height: 100)
                                 .background(Color.blue)
                                 .foregroundColor(.white)
                                 .cornerRadius(10)
                                 
                                 */
                            }
                        //} //:LAZYVGRID
                        //.padding(.horizontal)
                    }//: SCROLLVIEW
                }else if isGroup{ //isGroups
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
            }//:ZStack
            Spacer()
        }//:VStack
    }
}

#Preview {
    CatalogView()
}
