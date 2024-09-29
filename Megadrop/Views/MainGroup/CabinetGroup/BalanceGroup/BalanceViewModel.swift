//
//  BalanceViewModel.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 31.07.2024.
//

import Foundation
class BalanceViewModel: ObservableObject{
    @Published var isLoadingBalance = true
    @Published var isLoadingBalanceSum = true
    
    static let sharedBalanceViewModel = BalanceViewModel()

    func loadBalanceAll(){
        loadBalanceSum()
        loadBalance()
    }
    
    func loadBalance() {
        self.isLoadingBalance = true
        let DROP_SHIPPING_DOMAIN = Constants.DROP_SHIPPING_DOMAIN + "/SHAPI/SH"+"/Balance"
        if let request = GroupManager.shared.getRequest(DROP_SHIPPING_DOMAIN: DROP_SHIPPING_DOMAIN){
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("Ошибка запроса: \(error?.localizedDescription ?? "No error description")")
                    self.isLoadingBalance = false
                    return
                }
                
                do {
                    let salesJSON = try JSONDecoder().decode([SaleXDTO].self, from: data)
                    DispatchQueue.main.async {
                        // Обновление массива в Basket
                        balances_.removeAll()
                        balances_.append(contentsOf: salesJSON)
                        self.isLoadingBalance = false
                    }
                } catch {
                    print("Ошибка десериализации JSON: \(error.localizedDescription)")
                }
            }.resume()
        }
    }
    
    func loadBalanceSum() {
        self.isLoadingBalanceSum = true
        let DROP_SHIPPING_DOMAIN = Constants.DROP_SHIPPING_DOMAIN + "/SHAPI/SH" + "/BalanceSum"
        if let request = GroupManager.shared.getRequest(DROP_SHIPPING_DOMAIN: DROP_SHIPPING_DOMAIN){
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("Ошибка запроса: \(error?.localizedDescription ?? "No error description")")
                    self.isLoadingBalanceSum = false
                    return
                }
                
                do {
                    let salesJSON = try JSONDecoder().decode([SaleXDTO].self, from: data)
                    DispatchQueue.main.async {
                        balanceSum.removeAll()
                        balanceSum.append(contentsOf: salesJSON)
                        self.isLoadingBalanceSum = false
                    }
                } catch {
                    print("Ошибка десериализации JSON: \(error.localizedDescription)")
                }
            }.resume()
        }
    }
}
