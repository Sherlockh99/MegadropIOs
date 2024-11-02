//
//  ContentViewModel.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 25.07.2024.
//

import Foundation
class ContentViewModel: ObservableObject{
    func checkAuthorization(login: String, password: String, completion: @escaping (Bool) -> Void) {

        let urlString = Constants.DROP_SHIPPING_DOMAIN + Constants.MEGA_DROP_LOGIN
        
        // Формирование URL для GET-запроса
        guard let url = URL(string: urlString) else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let credentials = "\(login):\(password)"
        let credentialsData = credentials.data(using: .utf8)!
        let base64Credentials = credentialsData.base64EncodedString()
        request.setValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(false)
                return
            }
            
            guard let data = data, let responseString = String(data: data, encoding: .utf8) else {
                completion(false)
                return
            }

            // Обработка строки ответа от сервера
            if !responseString.isEmpty {
                print(responseString)
                if responseString.contains("<!DOCTYPE html") {
                    completion(false)
                }else{
                    Profile.profileShared.nickname = responseString
                    completion(true)
                }
            } else {
                completion(false)
            }
        }
        
        task.resume()
    }
}
