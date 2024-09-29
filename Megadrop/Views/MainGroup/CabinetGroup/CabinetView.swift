//
//  CabinetView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 27.01.2024.
//

import SwiftUI
import UIKit

struct CabinetView: View {
    @State private var selection: TabCabinet = .main
    
    @State private var showShareSheet = false
    @State private var fileURL: URL?
    @EnvironmentObject var shopSettings: ShopSettings
    
    enum TabCabinet {
        case main
        case catalog
        case basket
        case cabinet
        case settings
    }
    
    var body: some View {
        VStack{
            if (shopSettings.isMain) {
                VStack{
                    LogoImage(image: Image("logo"))
                    
                    Text(Profile.profileShared.nickname)
                    Button{
                        shopSettings.isMyOrders = true
                        shopSettings.isMain = false
                    }label: {
                        Spacer()
                        Text("Мої замовлення")
                        Spacer()
                    }
                    
                    Button{
                        shopSettings.isMain = false
                        shopSettings.isBalance = true
                    }label: {
                        Spacer()
                        Text("Баланс")
                        Spacer()
                    }
                    
                    Button{
                        getPrice()
                    }label: {
                        Text("Получить прайс")
                    }
                    
                    /*
                     Button{
                     getOrders()
                     }label: {
                     Spacer()
                     Text("Взаєморозрахунки")
                     Spacer()
                     }
                     */
                    
                    if showShareSheet {
                        if let fileURL = fileURL {
                            DocumentShareView(fileURL: fileURL)
                        }
                    }
                    
                    Button{
                        shopSettings.isMain = false
                        shopSettings.isSettings = true
                    }label: {
                        Spacer()
                        Text("Налаштування")
                        Spacer()
                    }
                    Spacer()
                }
                
            } else if (shopSettings.isMyOrders) {
                MyOrdersView()
            } else if (shopSettings.isBalance){
                BalanceView()
            } else if (shopSettings.isSettings){
                SettingsView()
            }
                
            /*
            NavigationSplitView{
                /*
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
                    //SaveFileView()
                    
                    Button{
                        getPrice()
                    }label: {
                        Text("Получить прайс")
                    }
                    //NomenclatureView(nomenclature: nom)
                }label: {
                    Text("Получить прайс")
                }
                 
                
                 NavigationLink{
                /*
                     Button{
                         getOrders()
                     } label: {
                         Text("Взаєморозрахунки")
                     }
                 */
                 }label: {
                     Text("Взаєморозрахунки")
                 }
                 */
                /*
                if showShareSheet {
                    if let fileURL = fileURL {
                        DocumentShareView(fileURL: fileURL)
                    }
                }
                */
                /*
                NavigationLink{
                    SettingsView()
                }label: {
                    Text("Настройки")
                }
                Spacer()
                 */
            }detail: {
                Text("!")
                
            }
            .font(.system(.title, design: .rounded, weight: .bold))
            */
        }
    }
    
    func getOrders(){
        fetchFileFromServer()
    }
    
    func getPrice(){
        guard let url = URL(string: Constants.DROP_SHIPPING_DOMAIN + "/nomenclature/getPriceNomenclature/00000000907") else { return }
        // Создаем запрос
        var request = URLRequest(url: url)
        
        // Учетные данные пользователя
        let login = Profile.profileShared.username
        let password = Profile.profileShared.password
        
        // Кодируем учетные данные в формате Base64
        let loginString = "\(login):\(password)"
        guard let loginData = loginString.data(using: .utf8) else { return }
        let base64LoginString = loginData.base64EncodedString()
        
        // Добавляем заголовок для авторизации
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
 
        // Отправляем GET запрос на сервер
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
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
            
            saveFileToPhone(fileName: "price.json", fileData: data)
            
        }
        task.resume()
    }
    
    func fetchFileFromServer() {
        
        guard let url = URL(string: Constants.DROP_SHIPPING_DOMAIN + "/orders/getFile") else { return }
        
        // Создаем запрос
        var request = URLRequest(url: url)
        
        // Учетные данные пользователя
        let login = Profile.profileShared.username
        let password = Profile.profileShared.password
        
        // Кодируем учетные данные в формате Base64
        let loginString = "\(login):\(password)"
        guard let loginData = loginString.data(using: .utf8) else { return }
        let base64LoginString = loginData.base64EncodedString()
        
        // Добавляем заголовок для авторизации
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        // Отправляем GET запрос на сервер
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
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
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response String: \(responseString)")
            }
            
            // Парсим JSON
            do {
                if let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
                    
                    print("JSON Декодирован успешно: \(jsonDict)")
                    
                    //if let decodedData = Data(base64Encoded: fileData.fileData, )
                        
                    if let fileName = jsonDict["FileName"] {
                        if let fileDataBase64 = jsonDict["FileData"] {
                            if let fileData = Data(base64Encoded: fileDataBase64, options: .ignoreUnknownCharacters) {
                                saveFileToPhone(fileName: fileName, fileData: fileData)
                            }
                        }
                    }

/*
                    if let fileName = jsonDict["FileName"],
                       let fileDataBase64 = jsonDict["FileData"],
                       let fileData = Data(base64Encoded: fileDataBase64) {
                        
                        saveFileToPhone(fileName: fileName, fileData: fileData)
                    }
 */
                    
                } else {
                    print("Ошибка при парсинге JSON: некорректная структура")
                }
            } catch {
                print("Ошибка при декодировании JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func saveFileToPhone(fileName: String, fileData: Data) {
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            try fileData.write(to: fileURL)
            DispatchQueue.main.async {
                let activityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
                
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let rootViewController = windowScene.windows.first?.rootViewController {
                    rootViewController.present(activityViewController, animated: true, completion: nil)
                }
            }
        } catch {
            print("Ошибка при сохранении файла: \(error.localizedDescription)")
        }
    }
    
    func shareFile(fileURL: URL, viewController: UIViewController) {
        let documentController = UIDocumentInteractionController(url: fileURL)
        documentController.uti = "public.data" // Укажите правильный UTI для вашего файла
        documentController.presentOptionsMenu(from: viewController.view.frame, in: viewController.view, animated: true)
    }
    
    // Функция для получения пути к папке документов
    func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
}
 
struct DocumentShareView: UIViewControllerRepresentable {
    var fileURL: URL
    
    func makeUIViewController(context: Context) -> FileShareViewController {
        let viewController = FileShareViewController()
        viewController.fileURL = fileURL
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: FileShareViewController, context: Context) {
        // Не требуется обновлять
    }
}
    
class DocumentInteractionDelegate: NSObject, UIDocumentInteractionControllerDelegate {
    // Реализация методов делегата
}


#Preview {
    CabinetView()
        .environmentObject(ShopSettings())
}
