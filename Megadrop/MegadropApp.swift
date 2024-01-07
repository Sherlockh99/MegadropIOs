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

class YourViewModel: ObservableObject{
    @Published var isLoggedIn: Bool = true
    
    init() {
        self.isLoggedIn = false
        //self.isLoggedIn = true
    }
}

struct ContentViewModel: View{
    @EnvironmentObject var viewModel: YourViewModel
    
    var body: some View{
        if viewModel.isLoggedIn {
            MainViewNew()
        }else{
            LoginView()
        }
    }
}

struct MainViewNew: View {
    var body: some View {
        Text("Main page")
    }
}
