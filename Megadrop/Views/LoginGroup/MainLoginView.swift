//
//  LoginView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 27.01.2024.
//

import SwiftUI

struct MainLoginView: View {
    @AppStorage("onboarding") var isLogged = false
    
    var body: some View {
        ZStack {
            CustomBackgroundView()
            
            VStack {
                LogoCircleImage(image: Image("logo"))
                ProfileLoginView().padding()
                
                Button {
                    isLogged = true
                } label: {
                    Text("Login")
                        .font(.title2)
                        .fontWeight(.heavy)
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
                        .shadow(color: .black.opacity(0.25), radius: 0.25, x: 1, y: 2)
                }
                .buttonStyle(GradientButton())
            }
            
        }
        .frame(width: 350,height: 700)
    }
}

#Preview {
    MainLoginView()
}
