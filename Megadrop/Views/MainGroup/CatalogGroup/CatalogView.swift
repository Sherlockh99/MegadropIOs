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
    @State private var isGroup = true
    @State private var idGroup = ""
    //@ObservedObject private var viewModel = GroupManager.shared

    let items = Array(1...30)  // Массив чисел от 1 до 30

    let columns: [GridItem] = [
        GridItem(.fixed(100)),
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
                if(isGroup){
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(groupWithNomenclatures, id: \.self) { item in
                                Button("\(item.NameGroup)"){
                                    isGroup = false
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
                        }
                        .padding(.horizontal)
                    }
                }else{ //isGroup
                    Button("Press me"){
                        isGroup = true
                    }
                }//:else isGroup
            }//:ZStack
            Spacer()
        }//:VStack
    }
}

#Preview {
    CatalogView()
}
