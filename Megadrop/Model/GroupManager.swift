//
//  GroupMnager.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 14.04.2024.
//

import Foundation
class GroupManager: ObservableObject{
    static let shared = GroupManager()
    //@Published var groupWithNomenclatures: [GroupWithNomenclatures] = []
    @Published var isLoading = false
    //@Published var isPictureLoaded = false
    @Published var isUpdatedQuality = false
    
    
    private init() {}
    
    public func getRequest(DROP_SHIPPING_DOMAIN: String) -> URLRequest?{
        guard let url = URL(string: DROP_SHIPPING_DOMAIN) else {
            print("Некорректный URL")
            self.isLoading = false
            return nil
        }
        
        // Создаем запрос
        var request = URLRequest(url: url)
        
        // Учетные данные пользователя
        let username = "z0002"
        let password = "1"
        
        // Кодируем учетные данные в формате Base64
        let loginString = "\(username):\(password)"
        guard let loginData = loginString.data(using: .utf8) else { return nil}
        let base64LoginString = loginData.base64EncodedString()
        
        // Добавляем заголовок для авторизации
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    func loadGroupWithNomenclatures() {
        self.isLoading = true
        
        
        let DROP_SHIPPING_DOMAIN = "http://77.52.194.194/itpeople/hs/nomenclature/getGroupsAndNomenclatures"
        if let request = getRequest(DROP_SHIPPING_DOMAIN: DROP_SHIPPING_DOMAIN){
            
            // Создание конфигурации сессии
            //let configuration = URLSessionConfiguration.default

            // Задание таймаута для ожидания данных
            //configuration.timeoutIntervalForRequest = 30 // 10 секунд для таймаута запроса

            // Задание таймаута для ожидания ресурса
            //configuration.timeoutIntervalForResource = 30 // 20 секунд для таймаута ресурса

            // Создание сессии с указанной конфигурацией
            //let session = URLSession(configuration: configuration)

            URLSession.shared.dataTask(with: request) { data, response, error in
            //session.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("Ошибка запроса: \(error?.localizedDescription ?? "No error description")")
                    self.isLoading = false
                    return
                }
                
                do {
                    // Десериализация JSON в массив экземпляров Nomenclature2
                    let groupWithNomenclaturesJSON = try JSONDecoder().decode([GroupWithNomenclatures].self, from: data)
                    DispatchQueue.main.async {
                        // Обновление массива в NomenclatureManager
                        //self.groupWithNomenclatures.append(contentsOf: groupWithNomenclaturesJSON)
                        groupWithNomenclatures.append(contentsOf: groupWithNomenclaturesJSON)
                        self.isLoading = false
                    }
                } catch {
                    print("Ошибка десериализации JSON: \(error.localizedDescription)")
                }
            }.resume()
        }
    }
    
   func getNameCharacteristic(groupID: String, nomenclatureID: String, characteristicID: Int)->String{
        if let groupIndex = groupWithNomenclatures.firstIndex(where: { $0.IDGroup == groupID }) {
            if let nomenclatureIndex = groupWithNomenclatures[groupIndex].Nomenclatures?.firstIndex(where: { $0.IDNomenclature == nomenclatureID }) {
                if let characteristicIndex = groupWithNomenclatures[groupIndex].Nomenclatures?[nomenclatureIndex].Characteristics?.firstIndex(where: {$0.IDCharacteristic == characteristicID}){
                    
                    return groupWithNomenclatures[groupIndex].Nomenclatures?[nomenclatureIndex].Characteristics![characteristicIndex].Characteristic ?? ""
                    
                }
            }
        }
        return ""

    }
    
    func setQualityAndPriceCharacteristic(groupID: String, 
                                          nomenclatureID: String,
                                          characteristicID: Int,
                                          orderedQuality: Int,
                                          price: Double){
        
        if let groupIndex = groupWithNomenclatures.firstIndex(where: { $0.IDGroup == groupID }) {
            if let nomenclatureIndex = groupWithNomenclatures[groupIndex].Nomenclatures?.firstIndex(where: { $0.IDNomenclature == nomenclatureID }) {
                if let characteristicIndex = groupWithNomenclatures[groupIndex].Nomenclatures?[nomenclatureIndex].Characteristics?.firstIndex(where: {$0.IDCharacteristic == characteristicID}){
 
                    groupWithNomenclatures[groupIndex].Nomenclatures?[nomenclatureIndex].Characteristics![characteristicIndex].OrderedQuality = orderedQuality

                    groupWithNomenclatures[groupIndex].Nomenclatures?[nomenclatureIndex].Characteristics![characteristicIndex].Price = price


                }
            }
        }
    }
    
    func updateImageNomenclature(groupID: String, nomenclatureID: String, newImage: String?) {
        if let groupIndex = groupWithNomenclatures.firstIndex(where: { $0.IDGroup == groupID }) {
            if let nomenclatureIndex = groupWithNomenclatures[groupIndex].Nomenclatures?.firstIndex(where: { $0.IDNomenclature == nomenclatureID }) {
                groupWithNomenclatures[groupIndex].Nomenclatures?[nomenclatureIndex].Image = newImage
            }
        }
    }
    
    func updateFullDataNomenclature(groupID: String, nomenclatureID: String, nom2: Nomenclature2){
        if let groupIndex = groupWithNomenclatures.firstIndex(where: { $0.IDGroup == groupID }) {
            if let nomenclatureIndex = groupWithNomenclatures[groupIndex].Nomenclatures?.firstIndex(where: { $0.IDNomenclature == nomenclatureID }) {
                groupWithNomenclatures[groupIndex].Nomenclatures?[nomenclatureIndex].Details = nom2.Details
                groupWithNomenclatures[groupIndex].Nomenclatures?[nomenclatureIndex].Characteristics = nom2.Characteristics
            }
        }
    }
    
    func getGroup(groupID: String) -> GroupWithNomenclatures?{
        if let groupIndex = groupWithNomenclatures.firstIndex(where: { $0.IDGroup == groupID }) {
            return groupWithNomenclatures[groupIndex]
        }
        return nil
    }
    
    func getCharacteristic(groupID: String, nomenclatureID: String, characteristicID: Int) -> Characteristicses? {
        if let groupIndex = groupWithNomenclatures.firstIndex(where: { $0.IDGroup == groupID }) {
            if let nomenclatureIndex = groupWithNomenclatures[groupIndex].Nomenclatures?.firstIndex(where: { $0.IDNomenclature == nomenclatureID }) {
                if let characteristicIndex = groupWithNomenclatures[groupIndex].Nomenclatures?[nomenclatureIndex].Characteristics?.firstIndex(where: {$0.IDCharacteristic == characteristicID}){
                    return groupWithNomenclatures[groupIndex].Nomenclatures?[nomenclatureIndex].Characteristics![characteristicIndex]
                }
            }
        }
        return nil
    }
    

}
