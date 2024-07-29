//
//  MegadropApp.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 07.01.2024.
//

import SwiftUI

@main
struct MegadropApp: App {
   //@StateObject var viewModel = YourViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentViewModel_()
                //.environmentObject(viewModel)
        }
    }
}

struct ContentView: View {
    @AppStorage("onboarding") var isLogged = false
    @StateObject private var viewModel = ContentViewModel()
    @ObservedObject var profile = Profile.profileShared
    
    var body: some View {
            Group {
                if isLogged {
                    MainView()
                        .onAppear {
                            viewModel.checkAuthorization(login: profile.username, password: profile.password){isAuthorized in
                                if !isAuthorized {
                                    isLogged = false
                                }
                            }
                        }
                        .environmentObject(Shop())
                        .environmentObject(ShopRecycle())
                } else {
                    MainLoginView()
                }
            }
        }
    
}

struct ContentViewModel_: View{
    //@EnvironmentObject var viewModel: YourViewModel
    
    var body: some View{
        MainView()
            .environmentObject(Shop())
            .environmentObject(ShopRecycle())
    }
}
