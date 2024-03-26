//
//  HomePageView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 27.01.2024.
//

import SwiftUI

struct HomePageView: View {
    
    // MARK: - PROPERTY
    
    @EnvironmentObject var shop: Shop
    @EnvironmentObject var vm: HomePageVM
    @StateObject var loader = DataLoader()
    
    var _body: some View {
        NavigationSplitView{
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    ForEach(vm.groupsWithNomenclatures){ gr in
                        HomePageGroup(groupWithNomenclatures: gr)
                    }
                }
            }
        } detail: {
            Text("Select a Landmark")
        }
        .onAppear{
            //onAppear вызывается перед прорисовкой модели
            Task {
                await vm.fetchDataLocal()
            }
        }
    }
    
    var body: some View {
        VStack{
            NavigationSplitView{
                ScrollView(.vertical, showsIndicators: false){
                    ForEach(loader.dataList,id: \.self){key in
                        HomePageGroup(groupWithNomenclatures: key)
                    }
                    .onAppear() {
                        loader.loadData()
                    }
                }
            } detail: {
                Text("Select a Landmark")
            }
        }
    }
    
}

#Preview {
    HomePageView()
        .environmentObject(Shop())
}
