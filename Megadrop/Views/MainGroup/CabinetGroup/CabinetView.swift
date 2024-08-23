//
//  CabinetView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 27.01.2024.
//

import SwiftUI

struct FileData: Codable {
    let FileName: String
    let FileData: String
}

struct CabinetView: View {
    @State private var selection: TabCabinet = .main

    //@Binding var isLogged: Bool

    enum TabCabinet {
        case main
        case catalog
        case basket
        case cabinet
        case settings
    }

    var body: some View {
        //if(selection == .settings){
        //    SettingsView(isLogged: $isLogged)
        //}else{
            NavigationSplitView{
                LogoImage(image: Image("logo"))
                Text(Profile.profileShared.nickname)
                NavigationLink{
                    MyOrdersView()
                }label: {
                    Text("Мої замовлення")
                }
                NavigationLink{
                    BalanceView()
                }label: {
                    Text("Баланс")
                }
                NavigationLink{
                    //NomenclatureView(nomenclature: nom)
                }label: {
                    Text("Получить прайс")
                }
                
               NavigationLink{
                   SaveJSONFileView()
               }label: {
                   Text("Взаиморасчеты")
               }
                Button{
                    getOrders()
                } label: {
                    //HStack{
                    //    Spacer()
                        Text("Взаєморозрахунки")
                    //    Spacer()
                    //}
                    //.font(.system(.title2, design: .rounded, weight: .bold))
                }

                NavigationLink{
                    //SettingsView(isLogged: $isLogged)
                    SettingsView()
                }label: {
                    Text("Настройки")
                }
                /*
                Button{
                    selection = .settings
                } label: {
                    //HStack{
                    //    Spacer()
                        Text("Настройки")
                    //    Spacer()
                    //}
                    //.font(.system(.title2, design: .rounded, weight: .bold))
                }
                 */
                Spacer()
            }detail: {
                Text("!")
            }
            .font(.system(.title, design: .rounded, weight: .bold))
        //}
    }
    
    func getOrders(){
        fetchFileFromServer()
    }
    
    
    func fetchFileFromServer() {
        
        let DROP_SHIPPING_DOMAIN = "http://192.168.0.243:43439/itpeople/hs/orders/getFile"
        
        guard let url = URL(string: DROP_SHIPPING_DOMAIN) else { return }
       
        // Создаем запрос
        var request = URLRequest(url: url)
        
        // Учетные данные пользователя
        //let login = Profile.profileShared.username
        //let password = Profile.profileShared.password
        
        let login = "z0002"
        let password = "1"

        
        // Кодируем учетные данные в формате Base64
        let loginString = "\(login):\(password)"
        guard let loginData = loginString.data(using: .utf8) else { return }
        let base64LoginString = loginData.base64EncodedString()
        
        // Добавляем заголовок для авторизации
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
   
        // Отправляем GET запрос на сервер
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            //URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Проверяем на наличие ошибок
            if let error = error {
                print("Ошибка при запросе: \(error.localizedDescription)")
                return
            }
            
            // Проверяем, что данные получены
            guard let data = data else {
                print("Нет данных")
                return
            }
            
            // Парсим JSON
            do {
                
                let responseString = String(data: data, encoding: .utf8)
                print("Response String: \(responseString ?? "Нет данных")")
                
                
                let decoder = JSONDecoder()
                let fileData = try decoder.decode(FileData.self, from: data)
                
                let fileDataBase64 = fileData.FileData.replacingOccurrences(of: "\n", with: "")
                
                
                // Декодируем Base64 строку в Data
                 if let decodedData = Data(base64Encoded: fileData.FileData, options: .ignoreUnknownCharacters){
                   // Определяем путь для сохранения файла
                     let fileURL = getDocumentsDirectory().appendingPathComponent(fileData.FileName)
                   // Записываем данные в файл
                   try decodedData.write(to: fileURL)
                   print("Файл сохранён по адресу: \(fileURL)")
               } else {
                   print("Не удалось декодировать Base64 строку")
               }

            } catch {
                print("Ошибка при декодировании JSON: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    // Функция для получения пути к папке документов
    func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
}

#Preview {
    CabinetView()
}
