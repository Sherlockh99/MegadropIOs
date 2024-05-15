//
//  GroupsWithNomenclatures.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 27.01.2024.
//

import Foundation
import SwiftUI

struct GroupWithNomenclatures: Codable, Hashable, Identifiable{

    var id: String {IDGroup}
    var IDGroup: String
    var NameGroup: String
    var Image: String?
    
    var Nomenclatures: [Nomenclature2]?
    
    mutating func removeDuplicateNomenclatures() {
            guard let nomenclatures = Nomenclatures else { return }
            self.Nomenclatures = Array(Set(nomenclatures))
        }
}
