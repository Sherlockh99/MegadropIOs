//
//  Profile.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 21.01.2024.
//

import Foundation

class Profile: ObservableObject{
    //@Published var username: String
    //@Published var password: String
    //@Published var nickname: String
    var username: String
    var password: String
    var nickname: String
    
    static let profileShared = Profile(username: "", password: "", nickname: "")
        
    private init(username: String, password: String, nickname: String) {
        self.username = UserDefaults.standard.string(forKey: "username") ?? ""
        self.password = UserDefaults.standard.string(forKey: "password") ?? ""
        self.nickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
    }
    
    public func save() {
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(password, forKey: "password")
        UserDefaults.standard.set(nickname, forKey: "nickname")
    }
    	
}
