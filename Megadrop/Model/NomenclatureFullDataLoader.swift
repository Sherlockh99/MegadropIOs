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
        let hService = "/nomenclature/getfulldatanomenclature/" + idNomenclature
        let DROP_SHIPPING_DOMAIN = Constants.DROP_SHIPPING_DOMAIN + hService
        
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
                 if let decodedResponse = try? JSONDecoder().decode(Nomenclature2.self, from: data){
                     self.decodeNomenclature(groupID: groupID, nomenclature: decodedResponse)
                 }
             }
         }.resume()
        
    }
    
    func decodeNomenclature(groupID: String, nomenclature: Nomenclature2){
        DispatchQueue.global(qos: .background).async {
            self.shared.updateFullDataNomenclature(groupID: groupID, nomenclatureID: nomenclature.IDNomenclature, nom2: nomenclature)
        }
    }
}
