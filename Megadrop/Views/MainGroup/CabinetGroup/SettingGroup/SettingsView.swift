//
//  SettingsView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 12.02.2024.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("onboarding") var isLogged = true
    @AppStorage("showAviableOnly") private var showAviableOnly = false
    @ObservedObject var profile = Profile.profileShared
    
    var body: some View {
        NavigationSplitView{
            Text("Налаштування")
                .font(.system(size: 22, weight: .black))

            Toggle(isOn: $showAviableOnly) {
                Text("Тільки в наявності")
                    .font(.system(size: 14))
            }
            
            Spacer()
            Button{
                profile.username = ""
                profile.password = ""
                profile.nickname = ""
                profile.save()
                isLogged = false
            } label: {
                HStack{
                    Spacer()
                    Text("Выйти")
                    Spacer()
                }
            }
            NavigationLink{
                
                //AboutView()
            }label: {
                Text("О приложении")
            }
        } detail: {
            Text("!")
        }
        .padding()
    }
}


 #Preview {
     SettingsView()
 }
 
