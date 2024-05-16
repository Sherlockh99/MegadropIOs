//
//  FullDataLoader.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 29.03.2024.
//

import Foundation
import SwiftUI
class NomenclatureFullDataLoader: ObservableObject{
    @Published var isLoadedNDFL = false
    static let sharedNFDL = NomenclatureFullDataLoader()
    
    private var shared = GroupManager.shared
    
    private init() {}
    
    func loadFullNomenclatureData(groupID: String, idNomenclature: String) {
        //self.isLoadedNDFL = false
        let hService = "/nomenclature/getfulldatanomenclature/" + idNomenclature
        let DROP_SHIPPING_DOMAIN = "http://77.52.194.194/itpeople/hs" + hService
        
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
        
        
        // Создаем задачу для запроса данных
        let _: Void = URLSession.shared.dataTask(with: request) { (data, response, error) in
             // Проверяем наличие ошибки
             if let error = error {
                 print("Ошибка запроса данных: \(error.localizedDescription)")
                 //self.isLoadedNDFL = true
                 return
             }
             
             // Проверяем HTTP статус код и наличие данных
             guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                 print("Нет данных или ошибка HTTP")
                 //self.isLoadedNDFL = true
                 return
             }

             // Обрабатываем полученные данные
             if let dataString = String(data: data, encoding: .utf8) {
                print("Полученные данные: \(dataString)")
                 if let decodedResponse = try? JSONDecoder().decode(Nomenclature2.self, from: data){
                     self.decodeNomenclature(groupID: groupID, nomenclature: decodedResponse)
                 }
                 //self.isLoadedNDFL = true
               // completion(data)
             }
         }.resume()
        
    }
    
    func decodeNomenclature(groupID: String, nomenclature: Nomenclature2){
        DispatchQueue.global(qos: .background).async {
            self.shared.updateFullDataNomenclature(groupID: groupID, nomenclatureID: nomenclature.IDNomenclature, nom2: nomenclature)
        }
    }
}
