//
//  MegadropApp.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 07.01.2024.
//

import SwiftUI

@main
struct MegadropApp: App {
   @StateObject var viewModel = YourViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentViewModel()
                .environmentObject(viewModel)
        }
    }
}

struct ContentViewModel: View{
    @EnvironmentObject var viewModel: YourViewModel
    
    var body: some View{
        MainView()
            .environmentObject(Shop())
    }
}
