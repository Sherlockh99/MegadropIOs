//
//  BuyViewModel.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 01.07.2024.
//

import Foundation
import Combine
class BuyViewModel: ObservableObject {
    
    @Published var phoneNumber: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var middleName: String = ""
    @Published var cities: [String] = []
    @Published var branches: [String] = []
    @Published var city: String = ""
    @Published var shopRecycleIsBuy = false
    
    private let login = Profile.profileShared.username
    private let password = Profile.profileShared.password
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Подписываемся на изменения phoneNumber
        $phoneNumber
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] newPhoneNumber in
                self?.fetchUserData(phoneNumber: newPhoneNumber)
            }
            .store(in: &cancellables)
        
        $city
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] newCity in
                self?.fetchBranches(city: newCity)
            }
            .store(in: &cancellables)
    }
    
    //получаем покупателя по телефонному номеру
    func fetchUserData(phoneNumber: String) {
        
        firstName = ""
        lastName = ""
        middleName = ""
        guard phoneNumber.count >= 10 else {
            return
        }
      
        let urlString = Constants.DROP_SHIPPING_DOMAIN + "/clients/getcontactsfromphonenumbern/" + phoneNumber
        let url = URL(string: urlString)!
    
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let credentials = "\(login):\(password)"
        let credentialsData = credentials.data(using: .utf8)!
        let base64Credentials = credentialsData.base64EncodedString()
        request.setValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received.")
                return
            }
            
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    self.firstName = user.FirstName
                    self.lastName = user.LastName
                    self.middleName = user.MiddleName
                }
            } catch {
                print("Failed to decode cities: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    //получить город по индексу
    func fetchCityByBranch(branch: String) {
        guard branch.count >= 5 else {
            return
        }
        
        let urlString = Constants.DROP_SHIPPING_DOMAIN + "/delivery/getbranchukrposhta/" + branch
        let url = URL(string: urlString)!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let credentials = "\(login):\(password)"
        let credentialsData = credentials.data(using: .utf8)!
        let base64Credentials = credentialsData.base64EncodedString()
        request.setValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received.")
                return
            }
            
            do {
                let city = try JSONDecoder().decode(DeliveryXDTO.self, from: data)
                DispatchQueue.main.async {
                    self.city = city.Locality
                }
            } catch {
                print("Failed to decode city: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    //получить список населенных пунктов Новой Почты
    func fetchCities() {
        
        if (!self.cities.isEmpty){return}
        
        let url = URL(string: Constants.DROP_SHIPPING_DOMAIN + "/delivery/getcitiesnovaposhta")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let credentials = "\(login):\(password)"
        let credentialsData = credentials.data(using: .utf8)!
        let base64Credentials = credentialsData.base64EncodedString()
        request.setValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received.")
                return
            }
            
            do {
                let cities = try JSONDecoder().decode([String].self, from: data)
                DispatchQueue.main.async {
                    self.cities = cities
                }
            } catch {
                print("Failed to decode cities: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    func fetchBranches(city: String) {
        if (city.isEmpty){return}
       
        let urlString = Constants.DROP_SHIPPING_DOMAIN + "/delivery/getdepartmentsnovaposhta/" + city
        let url = URL(string: urlString)!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let credentials = "\(login):\(password)"
        let credentialsData = credentials.data(using: .utf8)!
        let base64Credentials = credentialsData.base64EncodedString()
        request.setValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received.")
                return
            }
            
            do {
                let branches = try JSONDecoder().decode(NovaPoshtaBranchesOfCityXDTO.self, from: data)
                DispatchQueue.main.async {
                    self.branches = branches.Departments
                }
            } catch {
                print("Failed to decode branches: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    
    func confirmOrder(deliveryService: String, city: String, branchNumber: String, paymentMethod: String, paymentAmount: String, sendWithMyInvoice: Bool, invoiceNumber: String, comment: String) {
        
        let urlString = Constants.DROP_SHIPPING_DOMAIN + "/delivery/PostOrderIPhone"
        let url = URL(string: urlString)!
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let credentials = "\(login):\(password)"
        let credentialsData = credentials.data(using: .utf8)!
        let base64Credentials = credentialsData.base64EncodedString()
        request.setValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "phoneNumber": phoneNumber,
            "firstName": firstName,
            "lastName": lastName,
            "middleName": middleName,
            "deliveryService": deliveryService,
            "city": city,
            "branchNumber": branchNumber,
            "paymentMethod": paymentMethod,
            "paymentAmount": paymentAmount,
            "sendWithMyInvoice": sendWithMyInvoice,
            "invoiceNumber": invoiceNumber,
            "comment": comment
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received.")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("Order confirmed successfully.")
                DispatchQueue.main.async {
                    self.shopRecycleIsBuy = true
                    //self.branches = branches.Departments
                }
                // Handle successful response
            } else {
                print("Failed to confirm order. Status code: \((response as? HTTPURLResponse)?.statusCode ?? -1)")
                // Handle error response
            }
        }
        
        task.resume()
    }
    
}
