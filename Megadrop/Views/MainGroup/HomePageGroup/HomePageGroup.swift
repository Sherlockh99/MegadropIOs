//
//  HomePageGroup.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 28.01.2024.
//

import SwiftUI

struct HomePageGroup: View {
    var groupWithNomenclatures: GroupWithNomenclatures
    @ObservedObject private var viewModel = GroupManager.shared

    var body: some View {
        Section(header: Text(groupWithNomenclatures.NameGroup)){
            //HomePageListNomenclature(IDGroup: groupWithNomenclatures.IDGroup, nomenclatures: groupWithNomenclatures.Nomenclatures ?? [])
            //if !viewModel.isLoading{
                //if let nomenclatures = groupWithNomenclatures.Nomenclatures {
                    //HomePageListNomenclature(IDGroup: groupWithNomenclatures.IDGroup, nomenclatures: groupWithNomenclatures.Nomenclatures)
                    //HomePageListNomenclature(IDGroup: groupWithNomenclatures, nomenclatures: nomenclatures)
                    HomePageListNomenclature(groupsWithNomenclatures_: groupWithNomenclatures)
                //}
            //}
        }
        .font(.headline)
        .padding(.leading, 15)
        .padding(.top, 5)
        .foregroundColor(.primary)
    }
}

#Preview {
    HomePageGroup(groupWithNomenclatures: ModelData().groupsWithNomenclatures[0])
}
