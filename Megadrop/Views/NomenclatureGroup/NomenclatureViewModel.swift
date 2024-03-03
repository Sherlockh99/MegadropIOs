//
//  NomenclatureViewData.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 26.02.2024.
//

import Foundation
func getDataNomenclature(nomenclature: Nomenclature2, completion: @escaping (Nomenclature2)->Void){
    var nom = nomenclature
   
    getData(hService: "/nomenclature/getfulldatanomenclature/" + nomenclature.IDNomenclature){
        modified in
        do{
            let decoder = JSONDecoder()
            let userData = try decoder.decode(Nomenclature2.self, from: modified)
            print("all ok")
            nom.Details = userData.Details
            nom.Image = userData.Image ?? ""
            nom.Characteristics = userData.Characteristics
            completion(nom)
        }catch{
            print("Error UserData")
        }
    }
}

func getPicturesNomenclature(nom1: Nomenclature2, completion: @escaping (Nomenclature2)->Void){
    var nom = nom1
    
    getData(hService: "/nomenclature/getdefaultpicture/" + nom.IDNomenclature){
        modified in
        do{
            let decoder = JSONDecoder()
            let userData = try decoder.decode(PictureNomenclature.self, from: modified)
            print("all ok")
            //nom.Details = userData.Details
            nom.Image = userData.Image ?? ""
            completion(nom)
        }catch{
            print("Error")
        }
    }
}
