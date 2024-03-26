//
//  LoginView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 27.01.2024.
//

import SwiftUI

struct MainLoginView: View {
    //@Binding var isLogged: Bool
    @AppStorage("onboarding") var isLogged = false
    var body: some View {
        ZStack {
            CustomBackgroundView()
            
            VStack {
                LogoCircleImage(image: Image("logo"))
                ProfileLoginView().padding()
                
                Button {
                    //ACTION:  Generate a random number
                    //print("The button was pressed!")
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
        /*
            NavigationView {
                VStack(alignment: .leading){
                    HStack{
                        Spacer()
                        LogoCircleImage(image: Image("logo"))
                        Spacer()
                    }
                    
                    ProfileLoginView().padding()
                    Button{
                        //selection = .main
                        isLogged = true
                        //isShowNewView = checkCondition()
                    } label: {
                        HStack{
                            Spacer()
                            Text("ЛОГИН")
                            Spacer()
                        }
                        .font(.system(.title2, design: .rounded, weight: .bold))
                    }
                    Spacer()
                }
            }
         */
    }
    
    
    func checkCondition() -> Bool {
        // Здесь реализуйте ваш алгоритм проверки
        // Верните true, если условие выполнено
        return true
    }
}

#Preview {
    MainLoginView()
    //@State var logged = false
    //return MainLoginView(isLogged: $logged)
}
