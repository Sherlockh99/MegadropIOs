//
//  ProfileLogin.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 21.01.2024.
//

import SwiftUI

struct ProfileLoginView: View {
    @ObservedObject var profile = Profile.profileShared
    
    var body: some View {
        HStack{
            
            Text("Username")
            Spacer()
            TextField("Username", text: $profile.username)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.trailing)
        }
            
        HStack{
            Text("Password")
            Spacer()
            SecureField("password", text: $profile.password)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.trailing)
        }
    }
}

#Preview {
    ProfileLoginView()
}
