//
//  BasketManager.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 27.04.2024.
//

import Foundation
class BasketManager: ObservableObject{
    
    static let sharedBasketManager = BasketManager()
    
    @Published var isLoadingBasketManager = false

    private init() {}
    
    
    func loadBasket() {
        self.isLoadingBasketManager = true
        let DROP_SHIPPING_DOMAIN = Constants.DROP_SHIPPING_DOMAIN + "/basket/getBasketWithoutPicturesM"
        if let request = GroupManager.shared.getRequest(DROP_SHIPPING_DOMAIN: DROP_SHIPPING_DOMAIN){
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("Ошибка запроса: \(error?.localizedDescription ?? "No error description")")
                    self.isLoadingBasketManager = false
                    return
                }
                
                do {
                    // Десериализация JSON в массив экземпляров Nomenclature2
                    let basketJSON = try JSONDecoder().decode([Basket].self, from: data)
                    DispatchQueue.main.async {
                        // Обновление массива в Basket
                        basket.removeAll()
                        basket.append(contentsOf: basketJSON)            
                        self.isLoadingBasketManager = false
        }
                } catch {
                    print("Ошибка десериализации JSON: \(error.localizedDescription)")
                }
            }.resume()

        }
 
    }

}
