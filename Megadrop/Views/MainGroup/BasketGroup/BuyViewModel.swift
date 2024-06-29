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
    
    private var cancellables = Set<AnyCancellable>()
    
    private let username: String = "z0002"
    private let password: String = "1"
    private let DROP_SHIPPING_DOMAIN = "http://77.52.194.194/itpeople/hs"
    
    init() {
        // Подписываемся на изменения phoneNumber
        $phoneNumber
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] newPhoneNumber in
                self?.fetchUserData(phoneNumber: newPhoneNumber)
            }
            .store(in: &cancellables)
    }
    
    func fetchUserData(phoneNumber: String) {
        
        guard !phoneNumber.isEmpty, phoneNumber.count >= 10 else { return }
            
        
        let urlString = DROP_SHIPPING_DOMAIN + "/clients/getcontactsfromphonenumbern/\(phoneNumber)"
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        let loginString = "\(username):\(password)"
        
        guard let loginData = loginString.data(using: .utf8) else { return }
        let base64LoginString = loginData.base64EncodedString()
        
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTaskPublisher(for: request)
                .map { $0.data }
                .decode(type: User.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print("Ошибка при получении данных пользователя: \(error.localizedDescription)")
                    }
                }, receiveValue: { [weak self] user in
                    self?.firstName = user.FirstName
                    self?.lastName = user.LastName
                    self?.middleName = user.MiddleName
                    //self?.phoneNumber = user.PhoneNumber
                })
                .store(in: &cancellables)
        }
    
    func confirmOrder(deliveryService: String, city: String, branchNumber: String, paymentMethod: String, paymentAmount: String, sendWithMyInvoice: Bool, invoiceNumber: String, comment: String) {
        
        return
        /*
        guard phoneNumber.count >= 10 else {
            print("Phone number must be at least 10 digits long.")
            return
        }
        
        let urlString = DROP_SHIPPING_DOMAIN + "/delivery/PostOrder"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let loginString = "\(username):\(password)"
        guard let loginData = loginString.data(using: .utf8) else { return }
        let base64LoginString = loginData.base64EncodedString()
        
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
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
                // Handle successful response
            } else {
                print("Failed to confirm order. Status code: \((response as? HTTPURLResponse)?.statusCode ?? -1)")
                // Handle error response
            }
        }
        
        task.resume()
        */
    }
    
}
