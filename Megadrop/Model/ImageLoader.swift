//
//  ImageLoader.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 29.03.2024.
//

import Foundation
import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage? = nil
    
    func loadImageData(idNomenclature: String) {
        
        let hService = "/nomenclature/getdefaultpicture/" + idNomenclature
        let DROP_SHIPPING_DOMAIN = "http://77.52.194.194/itpeople/hs" + hService
        
        guard let url = URL(string: DROP_SHIPPING_DOMAIN) else { return }
        
        // Создаем запрос
        var request = URLRequest(url: url)
        
        // Учетные данные пользователя
        let login = Profile.profileShared.username
        let password = Profile.profileShared.password
        
        // Кодируем учетные данные в формате Base64
        let loginString = "\(login):\(password)"
        guard let loginData = loginString.data(using: .utf8) else { return }
        let base64LoginString = loginData.base64EncodedString()
        
        // Добавляем заголовок для авторизации
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        
        // Создаем задачу для запроса данных
        let _: Void = URLSession.shared.dataTask(with: request) { (data, response, error) in
             // Проверяем наличие ошибки
             if let error = error {
                 print("Ошибка запроса данных: \(error.localizedDescription)")
                 return
             }
             
             // Проверяем HTTP статус код и наличие данных
             guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                 print("Нет данных или ошибка HTTP")
                 return
             }

             // Обрабатываем полученные данные
             if let dataString = String(data: data, encoding: .utf8) {
                print("Полученные данные: \(dataString)")
                 if let decodedResponse = try? JSONDecoder().decode(ImageData.self, from: data){
                     self.decodeImage(fromBase64: decodedResponse.Image)
                 }
             }
         }.resume()
        
    }
    
    func decodeImage(fromBase64 base64String: String) {
        print("Decode Image Start")
        DispatchQueue.global(qos: .background).async {
            if let imageData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) {
                print("Decode Image Next")
                DispatchQueue.main.async {
                    self.image = UIImage(data: imageData)
                }
            }
        }
    }
}
