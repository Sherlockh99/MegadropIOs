//
//  NavigationBarView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 16.05.2024.
//

import SwiftUI

struct NavigationBarHomeView: View {
    // MARK: - PROPERTY
    
    @State private var isAnimated: Bool = false
    
    // MARK: - BODY
    
    var body: some View {
        HStack {
            LogoView()
              .opacity(isAnimated ? 1 : 0)
              .offset(x: 0, y: isAnimated ? 0 : -25)
              .onAppear(perform: {
                withAnimation(.easeOut(duration: 0.5)) {
                  isAnimated.toggle()
                }
              })
        }
    }
}

#Preview {
    NavigationBarHomeView()
}
