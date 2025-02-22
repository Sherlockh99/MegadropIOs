//
//  MegadropApp.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 07.01.2024.
//

import SwiftUI

@main
struct MegadropApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @AppStorage("onboarding") var isLogged = false
    @StateObject private var viewModel = ContentViewModel()
    @ObservedObject var profile = Profile.profileShared
    @AppStorage("showAviableOnly") private var showAviableOnly = false
    
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
                        isAviableOnly = showAviableOnly
                    }
                    .environmentObject(Shop())
                    .environmentObject(ShopRecycle())
                    .environmentObject(ShopSettings())
            } else {
                MainLoginView()
            }
        }
    }
}

struct ContentViewModel_: View{
    
    var body: some View{
        MainView()
            .environmentObject(Shop())
            .environmentObject(ShopRecycle())
    }
}
