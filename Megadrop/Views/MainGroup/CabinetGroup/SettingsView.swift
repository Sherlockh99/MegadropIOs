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
    @State private var statePage: Int = 0
    
    var body: some View {
        VStack{
        }
        if statePage == 0 {
            VStack{
                NavigationBarDetailView()
                
                Text("Налаштування")
                    .font(.system(size: 22, weight: .black))
                
                Toggle(isOn: $showAviableOnly) {
                    Text("Тільки в наявності")
                        .font(.system(size: 14))
                }
                
                Button{
                    statePage = 1
                }label: {
                    Spacer()
                    Text("Про додаток")
                    Spacer()
                }
                
                Button{
                    profile.username = ""
                    profile.password = ""
                    profile.nickname = ""
                    profile.save()
                    isLogged = false
                } label: {
                    HStack{
                        Spacer()
                        Text("Вийти")
                        Spacer()
                    }
                }
                Spacer()
                
            }
            .onReceive([self.showAviableOnly].publisher.first()) { newValue in
                if newValue != isAviableOnly {
                    isAviableOnly = newValue
                    groupWithNomenclatures = []
                    GroupManager.shared.loadGroupWithNomenclatures()
                }
            }
        } else if(statePage == 1){
            //} else if(shopSettings.isAbout){
            VStack{
                AboutApplicationView()
                Spacer()
                Button{
                    statePage = 0
                }label: {
                    Spacer()
                    Text("Назад")
                    Spacer()
                }
            }
        }
    }
}


 #Preview {
     SettingsView()
 }
 
