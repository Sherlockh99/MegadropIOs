//
//  FullDataLoader.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 29.03.2024.
//

import Foundation
import SwiftUI
class NomenclatureFullDataLoader: ObservableObject{
    @Published var nomenclature2: Nomenclature2? = nil
    //@EnvironmentObject var shop: Shop
    
    func loadFullNomenclatureData(idNomenclature: String) {
        
        let hService = "/nomenclature//getfulldatanomenclature/" + idNomenclature
        let DROP_SHIPPING_DOMAIN = "http://77.52.194.194/itpeople/hs" + hService
        //let s = "http://77.52.194.194/itpeople/hs/nomenclature/getdefaultpicture/00000002381"
        
        guard let url = URL(string: DROP_SHIPPING_DOMAIN) else { return }
        
        // Создаем запрос
        var request = URLRequest(url: url)
        
        // Учетные данные пользователя
        let username = "z0002"
        let password = "1"
        
        // Кодируем учетные данные в формате Base64
        let loginString = "\(username):\(password)"
        guard let loginData = loginString.data(using: .utf8) else { return }
        let base64LoginString = loginData.base64EncodedString()
        
        // Добавляем заголовок для авторизации
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        
       // guard let url = URL(string: DROP_SHIPPING_DOMAIN) else { return }
        
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
                 if let decodedResponse = try? JSONDecoder().decode(Nomenclature2.self, from: data){
                     self.decodeNomenclature(nomenclature: decodedResponse)
                 }
                 //let imageData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters)
               // completion(data)
             }
         }.resume()
        
    }
    
    func decodeNomenclature(nomenclature: Nomenclature2){
        DispatchQueue.global(qos: .background).async {
            
            //if let _nomenclature2 = nomenclature {
                self.nomenclature2 = nomenclature
                //self.shop.selectedNomenclature = nomenclature
            //}
        }
            /*
            if let image = nomenclature.Image {
                if let imageData = Data(base64Encoded: image, options: .ignoreUnknownCharacters) {
                    print("Decode Image Next")
                    DispatchQueue.main.async {
                        self.image = UIImage(data: imageData)
                        //guard let data = Data(base64Encoded: imageDataString, options: .ignoreUnknownCharacters) else { return }
                    }
                }
            }
             */
            
            
    }
}
    
/*
    func decodeImage(fromBase64 base64String: String) {
        print("Decode Image Start")
        DispatchQueue.global(qos: .background).async {
            if let imageData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) {
                print("Decode Image Next")
                DispatchQueue.main.async {
                    self.image = UIImage(data: imageData)
                    //guard let data = Data(base64Encoded: imageDataString, options: .ignoreUnknownCharacters) else { return }
                }
            }
        }
    }
}
*/
