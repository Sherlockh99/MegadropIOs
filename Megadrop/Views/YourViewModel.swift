//
//  YourViewModel.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 18.02.2024.
//

import Foundation

class YourViewModel: ObservableObject{
    @Published var isLoggedIn: Bool
    
    init() {
        self.isLoggedIn = false
    }
}
