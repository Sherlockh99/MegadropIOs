//
//  MyOrdersManager.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 30.07.2024.
//

import Foundation
class MyOrdersViewModel: ObservableObject{
    @Published var isLoadingMyOrdersManager = false
    static let sharedMyOrdersManager = MyOrdersViewModel()
    
    
    func loadMyOrders() {
        self.isLoadingMyOrdersManager = true
        let DROP_SHIPPING_DOMAIN = Constants.DROP_SHIPPING_DOMAIN + "/orders"+"/getallorders"
        if let request = GroupManager.shared.getRequest(DROP_SHIPPING_DOMAIN: DROP_SHIPPING_DOMAIN){
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("Ошибка запроса: \(error?.localizedDescription ?? "No error description")")
                    self.isLoadingMyOrdersManager = false
                    return
                }
                
                do {
                    let ordersJSON = try JSONDecoder().decode([OrdersXDTO].self, from: data)
                    DispatchQueue.main.async {
                        // Обновление массива в Basket
                        orders.removeAll()
                        orders.append(contentsOf: ordersJSON)
                        self.isLoadingMyOrdersManager = false
                    }
                } catch {
                    print("Ошибка десериализации JSON: \(error.localizedDescription)")
                }
            }.resume()
        }
    }
}
