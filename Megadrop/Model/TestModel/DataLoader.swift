//
//  DataLoader.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 03.03.2024.
//

import Foundation
class DataLoader: ObservableObject {
    @Published var dataList: [GroupWithNomenclatures] = []
    static let sharedDataLoader = DataLoader()
    //private init() {}
    
    func loadData() {
        let DROP_SHIPPING_DOMAIN = "http://77.52.194.194/itpeople/hs/nomenclature/getGroupsAndNomenclatures"
        
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
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                if let data = data {
                    let decodedData = try JSONDecoder().decode([GroupWithNomenclatures].self, from: data)
                    DispatchQueue.main.async {
                        self.dataList = decodedData
                    }
                } else {
                    print("No data")
                }
            } catch {
                print("Error decoding: \(error)")
            }
        }.resume()
    }
    
    func loadFullDataNomenclature(){
        
    }
}
