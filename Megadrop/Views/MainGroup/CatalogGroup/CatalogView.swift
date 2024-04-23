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
    
    let items = Array(1...30)  // Массив чисел от 1 до 30

    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
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
            ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(items, id: \.self) { item in
                                Text("\(item)")
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal)
                    }
            Spacer()
        }//VStack
    }
}

#Preview {
    CatalogView()
}
