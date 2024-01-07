//
//  LoginView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 27.01.2024.
//

import SwiftUI

struct LoginView: View {
    @State private var isLinkActive = false
    @State public var isShowNewView = false
    
    var body: some View {
        if isShowNewView {
            MainView()
        } else {
            NavigationView {
                VStack(alignment: .leading){
                    HStack{
                        Spacer()
                        LogoCircleImage(image: Image("logo"))
                        Spacer()
                    }
                    
                    ProfileLoginView().padding()
                    Button{
                        isShowNewView = checkCondition()
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
        }
    }
    
    func checkCondition() -> Bool {
        // Здесь реализуйте ваш алгоритм проверки
        // Верните true, если условие выполнено
        return true
    }
}

#Preview {
    LoginView()
}
