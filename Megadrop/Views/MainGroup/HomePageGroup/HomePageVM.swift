//
//  HomePageVM.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 12.02.2024.
//

import Foundation
final class HomePageVM: ObservableObject{
    @Published private(set) var groupsWithNomenclatures: [GroupWithNomenclatures] = []
    
    func fetchDataLocal() async{
        guard let downloadGroupsWithNomenclatures: [GroupWithNomenclatures] = await NetworkService.shared.downloadDataGroupWithNomenclatureLocal() else {return}
      
        groupsWithNomenclatures = downloadGroupsWithNomenclatures
    }
    
    
    func fetchData() async{
        guard let downloadGroupsWithNomenclatures: [GroupWithNomenclatures] = await NetworkService.shared.downloadDataGroupWithNomenclature() else {return}
      
        groupsWithNomenclatures = downloadGroupsWithNomenclatures

    }
}

