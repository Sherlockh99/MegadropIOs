//
//  LogoView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 16.03.2024.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        HStack(spacing: 4) {
          Text("MEGA".uppercased())
            .font(.title3)
            .fontWeight(.black)
            .foregroundColor(.primary)
          
          Image("logo")
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30, alignment: .center)
          
          Text("DROP".uppercased())
            .font(.title3)
            .fontWeight(.black)
            .foregroundColor(.primary)
        } //: HSTACK
    }
}

#Preview {
    LogoView()
}
