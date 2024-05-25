//
//  SearchView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 25.05.2024.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var isSearching = false
    
    var body: some View {
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
    }
}

#Preview {
    SearchView()
}
