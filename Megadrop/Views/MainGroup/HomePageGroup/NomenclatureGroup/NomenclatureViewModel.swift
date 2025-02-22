//
//  NomenclatureViewData.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 26.02.2024.
//

import Foundation
func getDataNomenclature(nomenclature: Nomenclature2, completion: @escaping (Nomenclature2)->Void){
    //var nom = nomenclature
   
    getData(hService: "/nomenclature/getfulldatanomenclature/" + nomenclature.IDNomenclature){
        modified in
        do{
            let decoder = JSONDecoder()
            let userData = try decoder.decode(Nomenclature2.self, from: modified)
            print("all ok")
            var nom2 = nomenclature
            nom2.Details = userData.Details
            nom2.Image = userData.Image ?? ""
            nom2.Characteristics = userData.Characteristics
            completion(nom2)
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

//func updateQualityInServer(groupID: String, nomenclatureID: String, characteristicID: Int, count: Int, completion: @escaping (BasketReply?) ->Void){
    //var qualityOrder: Int = 0
func updateQualityInServer(groupID: String, nomenclatureID: String, isCharacteristic: Bool, characteristicName: String, count: Int, completion: @escaping (BasketReply?) ->Void){
    var basketReply: BasketReply?
    
    var DROP_SHIPPING_DOMAIN = ""
    if isCharacteristic {
        DROP_SHIPPING_DOMAIN = "/nomenclature/addnomenclaturetorecyclewithcharacteristic/" +
        nomenclatureID + "/" +
        characteristicName + "/" +
        count.formatted()
    } else {
        DROP_SHIPPING_DOMAIN = "/nomenclature/addnomenclaturetorecyclewithoutcharacteristic/" +
        nomenclatureID + "/" +
        count.formatted()
    }
    
    //if let characteristic = GroupManager.shared.getCharacteristic(groupID: groupID, nomenclatureID: nomenclatureID, characteristicID: characteristicID){
    /*
    if let characteristic = GroupManager.shared.getCharacteristicName(groupID: groupID, nomenclatureID: nomenclatureID, nameCharacteristic: characteristicName){
        //let nameCharacteristic =  characteristic.Characteristic
        let isCharacteristic = characteristic.isCharacteristic

        var DROP_SHIPPING_DOMAIN = ""
        if(isCharacteristic){
            DROP_SHIPPING_DOMAIN = "/nomenclature/addnomenclaturetorecyclewithcharacteristic/" +
            nomenclatureID + "/" +
            characteristicName + "/" + 
            count.formatted()
        }else{
            DROP_SHIPPING_DOMAIN = "/nomenclature/addnomenclaturetorecyclewithoutcharacteristic/" +
            nomenclatureID + "/" +
            count.formatted()
        }
       */
        getData(hService: DROP_SHIPPING_DOMAIN){
            modified in
            do{
                
                let decoder = JSONDecoder()
                let userData = try decoder.decode(BasketReply.self, from: modified)
                print("all ok")
                basketReply = userData
                completion(basketReply)
                
            }catch{
                print("Error")
            }
        }
    //}
}
