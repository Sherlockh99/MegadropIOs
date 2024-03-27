//
//  NetworkService.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 10.02.2024.
//

import Foundation
final class NetworkService{
    static let shared = NetworkService()
    
    private init() {}
    
    func downloadDataGroupWithNomenclature() async -> [GroupWithNomenclatures]?{
        var groupsWithNomenclatures: [GroupWithNomenclatures] = []
        
         getData(hService: "nomenclature/getGroupsAndNomenclatures"){
            modified in
            do{
                let decoder = JSONDecoder()
                let userData = try decoder.decode([GroupWithNomenclatures].self, from: modified)
                //print("all ok")
                groupsWithNomenclatures = userData
                //nom.Details = userData.Details
                //nom.Image = userData.Image ?? ""
                //completion(nom)
                //return userData
            }catch{
                //let userData = GroupWithNomenclatures
                print("Error")
            }
        }
         
        //return a
        //return userData
        return groupsWithNomenclatures
        //return Product.mockData()
        //URLSession.shared.dataTask(with: URLRequest, completionHandler: (Data?, URLResponse?, Error?) -> Void)
    }
    
    
    func downloadDataGroupWithNomenclatureLocal() async -> [GroupWithNomenclatures]?{
        return load("GroupsAndNomenclatures2.json")
    }
    
}

func getData(hService: String, completion: @escaping (Data)->Void){
    //var nom = nomenclature
    
    let DROP_SHIPPING_DOMAIN = "http://77.52.194.194/itpeople/hs" + hService
    //nomenclature/getfulldatanomenclature/" + nomenclature.IDNomenclature
    
    guard let url = URL(string: DROP_SHIPPING_DOMAIN) else {
        print("Некорректный URL")
        return
    }
    
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
     let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
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
            completion(data)
         }
     }
    
    // Запускаем задачу
    task.resume()
}
