//
//  SaveJSONFileView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 22.08.2024.
//

import SwiftUI
import UIKit

struct SaveJSONFileView: View {
    @ObservedObject private var viewModelSaveJSONFile = SaveJSONFileViewModel.sharedSaveJSONFile
    //let ordeersFile = OrdersFileXDTO
    var body: some View {
        VStack {
            Button("Сохранить и поделиться файлом") {
                saveAndShareFileFromJSON()
            }

            Button("Сохранить и поделиться файлом 2") {
                if viewModelSaveJSONFile.isLoadingJSONFile == false {
                    saveAndShareFileFromJSON2()
                //}else{
                    //viewModelSaveJSONFile.loadFileJSON()
                }
            }
        }
        .onAppear{
            viewModelSaveJSONFile.loadFileJSON()
        }
    }
    
    func saveAndShareFileFromJSON2() {
        let jsonString = viewModelSaveJSONFile.jsonString
        //let fileName = viewModelSaveJSONFile.ordersFileXDTO.FileName
        
        if let jsonData = jsonString.data(using: .utf8),
           let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []),
           let jsonDict = jsonObject as? [String: String],
           let binaryDataString = jsonDict["FileData"],
           let fileName = jsonDict["FileName"]{
            
            // Декодируем строку Base64 в двоичные данные (Data)
            if let data = Data(base64Encoded: binaryDataString) {
                // Получаем путь для сохранения файла
                let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
                
                do {
                    // Записываем данные в файл
                    try data.write(to: fileURL)
                    
                    // Используем UIActivityViewController для возможности поделиться файлом или сохранить его
                    let activityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
                    
                    // Презентуем UIActivityViewController
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let rootViewController = windowScene.windows.first?.rootViewController {
                        rootViewController.present(activityViewController, animated: true, completion: nil)
                   }
                    
                } catch {
                    print("Ошибка при сохранении файла: \(error.localizedDescription)")
                }
            } else {
                print("Не удалось декодировать строку Base64")
            }
            
            
        }
    }
    
    
    func saveAndShareFileFromJSON() {
        // Предположим, что вы получили JSON с двоичными данными в виде строки Base64
        let jsonString = """
        {
            "fileName": "example.txt",
            "binaryData": "U29tZSBzYW1wbGUgdGV4dCBmb3IgdGhlIGZpbGU="
        }
        """
        
        // Парсим JSON строку в объект
        if let jsonData = jsonString.data(using: .utf8),
           let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []),
           let jsonDict = jsonObject as? [String: String],
           let binaryDataString = jsonDict["binaryData"],
           let fileName = jsonDict["fileName"] {
            
            
            // Декодируем строку Base64 в двоичные данные (Data)
            if let data = Data(base64Encoded: binaryDataString) {
                // Получаем путь для сохранения файла
                let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
                
                do {
                    // Записываем данные в файл
                    try data.write(to: fileURL)
                    
                    // Используем UIActivityViewController для возможности поделиться файлом или сохранить его
                    let activityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
                    
                    // Презентуем UIActivityViewController
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let rootViewController = windowScene.windows.first?.rootViewController {
                        rootViewController.present(activityViewController, animated: true, completion: nil)
                    }
                    
                } catch {
                    print("Ошибка при сохранении файла: \(error.localizedDescription)")
                }
            } else {
                print("Не удалось декодировать строку Base64")
            }
        } else {
            print("Ошибка при парсинге JSON")
        }
    }
    
    // Функция для получения пути к папке документов
    func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}


#Preview {
    SaveJSONFileView()
}
