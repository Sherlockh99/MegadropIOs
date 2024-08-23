//
//  ViewModelSaveJSONFile.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 23.08.2024.
//

import Foundation
class SaveJSONFileViewModel: ObservableObject{

    static let sharedSaveJSONFile = SaveJSONFileViewModel()
    
    @Published var isLoadingJSONFile = false
    @Published var ordersFileXDTO = OrdersFileXDTO(FileName: "", FileData: "")
    @Published var jsonString = ""
    
    private init() {}
    
    func loadFileJSON() {
        self.isLoadingJSONFile = true
        let DROP_SHIPPING_DOMAIN = Constants.DROP_SHIPPING_DOMAIN + "/orders/getFile"
        
        if let request = GroupManager.shared.getRequest(DROP_SHIPPING_DOMAIN: DROP_SHIPPING_DOMAIN){
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("Ошибка запроса: \(error?.localizedDescription ?? "No error description")")
                    self.isLoadingJSONFile = false
                    return
                }
                
                do {
                    // Десериализация JSON в массив экземпляров Nomenclature2
                    let ordersFileJSON = try JSONDecoder().decode(OrdersFileXDTO.self, from: data)
                    DispatchQueue.main.async {
                        //self.jsonString = ordersFileJSON
                        
                        self.ordersFileXDTO = ordersFileJSON
                        self.isLoadingJSONFile = false
        }
                } catch {
                    print("Ошибка десериализации JSON: \(error.localizedDescription)")
                }
            }.resume()

        }
        
    }

    
}
