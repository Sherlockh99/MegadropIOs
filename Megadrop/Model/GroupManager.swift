//
//  GroupMnager.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 14.04.2024.
//

import Foundation
import SwiftUI
class GroupManager: ObservableObject{
    static let shared = GroupManager()
    //@Published var groupWithNomenclatures: [GroupWithNomenclatures] = []
    @Published var isLoading = false
    //@Published var isLoadingNomenclature = false
    //@Published var isPictureLoaded = false
    @Published var isUpdatedQuality = false
    
    
    private init() {}
    
    public func getRequest(DROP_SHIPPING_DOMAIN: String) -> URLRequest?{
        guard let url = URL(string: DROP_SHIPPING_DOMAIN) else {
            print("Некорректный URL")
            self.isLoading = true
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
    
    func loadGroups(){
        self.isLoading = true

        let DROP_SHIPPING_DOMAIN = "http://77.52.194.194/itpeople/hs/nomenclature/getGroups"
        if let request = getRequest(DROP_SHIPPING_DOMAIN: DROP_SHIPPING_DOMAIN){
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("Ошибка запроса: \(error?.localizedDescription ?? "No error description")")
                    //self.isLoading = false
                    return
                }
                
                do {
                    // Десериализация JSON в массив экземпляров Nomenclature2
                    let groupWithNomenclaturesJSON = try JSONDecoder().decode([GroupWithNomenclatures].self, from: data)
                    DispatchQueue.main.async {
                        // Обновление массива в NomenclatureManager
                        //self.groupWithNomenclatures.append(contentsOf: groupWithNomenclaturesJSON)
                        groupWithNomenclatures.append(contentsOf: groupWithNomenclaturesJSON)
                        //self.isLoading = false
                        self.loadNomenclatures()
                    }
                } catch {
                    print("Ошибка десериализации JSON: \(error.localizedDescription)")
                }
            }.resume()
        }

    }
    
    func loadNomenclatures(){
        //self.isLoadingNomenclature = true
        //self.isLoading = true
        //let semaphore = DispatchSemaphore(value: 0)
        let aGroup = DispatchGroup()
        
        groupWithNomenclatures.forEach { key in
            aGroup.enter() // Отметить начало задачи
            let DROP_SHIPPING_DOMAIN = "http://77.52.194.194/itpeople/hs/nomenclature/getNomenclaturesGroup/" + key.IDGroup
            if let request = getRequest(DROP_SHIPPING_DOMAIN: DROP_SHIPPING_DOMAIN){
                URLSession.shared.dataTask(with: request) { data, response, error in
                    //defer { group.leave() }
                    guard let data = data, error == nil else {
                        print("Ошибка запроса: \(error?.localizedDescription ?? "No error description")")
                        //self.isLoadingNomenclature = false
                        //semaphore.signal()
                        aGroup.leave()
                        return
                    }
                    
                    do {
                        // Десериализация JSON в массив экземпляров Nomenclature2
                        let nomenclaturesJSON = try JSONDecoder().decode([Nomenclature2].self, from: data)
                        DispatchQueue.main.async {
                            //nomenclatures.append(contentsOf: nomenclaturesJSON)
                            self.addNomenclatures(groupID: key.IDGroup, nom2: nomenclaturesJSON)
                        }
                        aGroup.leave()
                    } catch {
                        print("Ошибка десериализации JSON: \(error.localizedDescription)")
                        aGroup.leave()
                    }
                    
                    //semaphore.signal()
                    
                }.resume()
            }
            //semaphore.wait() // Ожидаем сигнала
        }
        
        //semaphore.wait()
        // Этот блок кода выполнится после завершения всех задач в группе
       aGroup.notify(queue: DispatchQueue.main) {
            //self.isLoadingNomenclature = false
            self.isLoading = false
        }
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
                        print("Start")
                        groupWithNomenclatures.append(contentsOf: groupWithNomenclaturesJSON)
                        
                            for index in groupWithNomenclatures.indices {
                                groupWithNomenclatures[index].removeDuplicateNomenclatures()
                            }
  
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

    func getNomenclature(groupID: String, nomenclatureID: String) -> Nomenclature2? {
        if let groupIndex = groupWithNomenclatures.firstIndex(where: { $0.IDGroup == groupID }) {
            if let nomenclatureIndex = groupWithNomenclatures[groupIndex].Nomenclatures?.firstIndex(where: { $0.IDNomenclature == nomenclatureID }) {
                return groupWithNomenclatures[groupIndex].Nomenclatures?[nomenclatureIndex]
            }
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
    
    func addNomenclatures(groupID: String, nom2: [Nomenclature2]){
        if let groupIndex = groupWithNomenclatures.firstIndex(where: { $0.IDGroup == groupID }) {
            groupWithNomenclatures[groupIndex].Nomenclatures = nom2
        }
    }

    func getNomenclatures(groupID: String)->[Nomenclature2]?{
        if let groupIndex = groupWithNomenclatures.firstIndex(where: { $0.IDGroup == groupID }) {
            return groupWithNomenclatures[groupIndex].Nomenclatures ?? nil
        }
        return nil
    }
    
    func findNomenclatures(containing text: String) -> [Nomenclature2] {
        return groupWithNomenclatures
            .flatMap {$0.Nomenclatures ?? [] }
            .filter { $0.Nomenclature.localizedCaseInsensitiveContains(text) }
    }
}
