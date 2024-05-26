//
//  ModelData.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 27.01.2024.
//

import Foundation

@Observable
class ModelData{
    var groupsWithNomenclatures: [GroupWithNomenclatures] = load("GroupsAndNomenclatures2.json")
    var basketModelData: [Basket] = load("Basket.json")
}

func load<T: Decodable>(_ filename: String) -> T {
    //let data: Data
    
    // 1. Locate the JSON file
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    

    
    // 2. Create a property for the data
    guard let data = try? Data(contentsOf: file) else {
      fatalError("Failed to load \(file) from bundle.")
    }
    
    /*
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    */
    
    // 3. Create a decoder
    let decoder = JSONDecoder()
    
    // 4. Create a property for the decoded data
    guard let decodedData = try? decoder.decode(T.self, from: data) else {
      fatalError("Failed to decode \(file) from bundle.")
    }
    /*
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
     */
    
    // 5. Return the ready-to-use data
    return decodedData
}

extension Bundle {
  func decode<T: Codable>(_ file: String) -> T {
    // 1. Locate the JSON file
    guard let url = self.url(forResource: file, withExtension: nil) else {
      fatalError("Failed to locate \(file) in bundle.")
    }
    
    // 2. Create a property for the data
    guard let data = try? Data(contentsOf: url) else {
      fatalError("Failed to load \(file) from bundle.")
    }
    
    // 3. Create a decoder
    let decoder = JSONDecoder()
    
    // 4. Create a property for the decoded data
    guard let decodedData = try? decoder.decode(T.self, from: data) else {
      fatalError("Failed to decode \(file) from bundle.")
    }
    
    // 5. Return the ready-to-use data
    return decodedData
  }
}
