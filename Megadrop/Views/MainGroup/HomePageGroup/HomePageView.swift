//
//  HomePageView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 27.01.2024.
//

import SwiftUI

struct HomePageView: View {
    //@Environment(ModelData.self) var modelData
    var groupsWithNomenclatures = ModelData().groupsWithNomenclatures
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                ForEach(groupsWithNomenclatures){ gr in
                    HomePageGroup(groupWithNomenclatures: gr)
                }
            }
        }
    }
}

#Preview {
    HomePageView()
}
