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
    @State private var showNotification = false
    
    var body: some View {
        ZStack {
            //CustomBackgroundView()
            
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
                            withAnimation(.easeInOut) {
                                showNotification.toggle()
                            }
                            
                            // Автоматическое скрытие через 2 секунды
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation(.easeInOut) {
                                    showNotification = false
                                }
                            }
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
        .overlay(
            Group {
                if showNotification {
                    Text("Incorrect login or password!")
                        .padding()
                        .background(Color.black.opacity(0.6))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.bottom, 50)
                        .transition(.move(edge: .bottom))
                        //.animation(.easeInOut)
                }
            }
        )
        //.frame(width: 350,height: 700)
    }
}

#Preview {
    MainLoginView()
}
