//
//  NomenclatureManager.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 14.04.2024.
//

import Foundation
class NomenclatureManager {
    static let shared = NomenclatureManager()
    private init() {}
    var nomenclatures: [Nomenclature2] = []
    

    func addNomenclature(_ nomenclature: Nomenclature2) {
        nomenclatures.append(nomenclature)
    }

    func removeNomenclature(byId id: String) {
        nomenclatures.removeAll { $0.IDNomenclature == id }
    }
    
    func loadNomenclatures(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Ошибка запроса: \(error?.localizedDescription ?? "No error description")")
                return
            }
            
            do {
                // Десериализация JSON в массив экземпляров Nomenclature2
                let nomenclatures = try JSONDecoder().decode([Nomenclature2].self, from: data)
                DispatchQueue.main.async {
                    // Обновление массива в NomenclatureManager
                    self.nomenclatures.append(contentsOf: nomenclatures)
                }
            } catch {
                print("Ошибка десериализации JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}
