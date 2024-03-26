//
//  SettingsView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 12.02.2024.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("onboarding") var isLogged = true
    @State private var showFavoritesOnly = false
    //@State private var isExit = false
    
    var body: some View {
        //if (isExit) {
            //MainLoginView()
        //}else{
            NavigationSplitView{
                Text("Settings")
                Spacer()
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Только доступные")
                }
                NavigationLink{
                    //MyOrdersView()
                }label: {
                    Text("Изменить язык приложения")
                }
                Spacer()
                Button{
                    isLogged = false
                } label: {
                    HStack{
                        Spacer()
                        Text("Выйти")
                        Spacer()
                    }
                    //.font(.system(.title2, design: .rounded, weight: .bold))
                }
                NavigationLink{
                    AboutView()
                }label: {
                    Text("О приложении")
                }
                
            }detail: {
                Text("!")
            }
            .padding()
        //}
    }
}


 #Preview {
     SettingsView()
 }
 
