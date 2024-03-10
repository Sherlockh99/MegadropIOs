//
//  DataLoaderFullNomenclature.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 10.03.2024.
//

import Foundation
class DataLoaderFullNomenclature: ObservableObject{
    @Published var nomenclature = Nomenclature2()
    
    func loadData(IDNomenclature: String){
        let DROP_SHIPPING_DOMAIN = "http://77.52.194.194/itpeople/hs/nomenclature/getfulldatanomenclature/" + IDNomenclature
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
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                if let data = data {
                    let decodedData = try JSONDecoder().decode(Nomenclature2.self, from: data)
                    DispatchQueue.main.async {
                        self.nomenclature = decodedData
                    }
                } else {
                    print("No data")
                }
            } catch {
                print("Error decoding: \(error)")
            }
        }.resume()
    }
}
