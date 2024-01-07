//
//  Profile.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 21.01.2024.
//

import Foundation

class Profile: ObservableObject{
    @Published var username: String
    @Published var password: String

    static let profileShared = Profile(username: "", password: "")
        
    private init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
