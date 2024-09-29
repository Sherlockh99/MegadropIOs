//
//  LoginView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 27.01.2024.
//

import SwiftUI

struct MainLoginView: View {
    //@State private var username = ""
    //@State private var password = ""
    @AppStorage("onboarding") var isLogged = false
    //@State private var isLogged = false
    @StateObject private var viewModel = ContentViewModel()
    
    //@AppStorage("onboarding") var isLogged = false
    @ObservedObject var profile = Profile.profileShared
    //@StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        ZStack {
            CustomBackgroundView()
            
            VStack {
                LogoCircleImage(image: Image("logo"))
                ProfileLoginView().padding()
                
                Button {
                    viewModel.checkAuthorization(login: profile.username, password: profile.password) { isAuthorized in
                        if isAuthorized {
                            profile.save()
                            isLogged = true
                        } else {
                            // Handle failed authorization, e.g., show an alert
                            print("Authorization failed")
                        }
                    }
                } label: {
                    Text("Login")
                        .font(.title2)
                        .fontWeight(.heavy)
                    /*
                        .foregroundStyle(
                            LinearGradient(
                                colors: [
                                    .customGreenLight,
                                    .customGreenMedium
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                     */
                        .shadow(color: .black.opacity(0.25), radius: 0.25, x: 1, y: 2)
                }
                .buttonStyle(GradientButton())
            } //END: VStack
            .padding()
            
        }
        //.frame(width: 350,height: 700)
    }
}

#Preview {
    MainLoginView()
}
