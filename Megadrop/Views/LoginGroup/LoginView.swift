//
//  LoginView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 18.02.2024.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                HStack{
                    Spacer()
                    LogoCircleImage(image: Image("logo"))
                    Spacer()
                }
                
                ProfileLoginView().padding()
                Button{
                    //isShowNewView = checkCondition()
                } label: {
                    HStack{
                        Spacer()
                        Text("ЛОГИН")
                        Spacer()
                    }
                    //.font(.system(.title2, design: .rounded, weight: .bold))
                }
                Spacer()
            }
        }
    }
}

#Preview {
    LoginView()
}
