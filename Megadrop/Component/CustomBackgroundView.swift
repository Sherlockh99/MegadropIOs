//
//  CustomBackgroundView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 09.03.2024.
//

import SwiftUI

struct CustomBackgroundView: View {
    var body: some View {
        ZStack {
            
            // MARK: - 3. DEPTH
            Color.customGreenDark
                .offset(y: 12)
                .edgesIgnoringSafeArea(.all)
            
            // MARK: - 2. LIGHT
            Color.customGreenLight
                .offset(y: 3)
                .opacity(0.85)
                .edgesIgnoringSafeArea(.all)
            
            // MARK: - 1. SURFACE
            LinearGradient(
                colors: [
                    .customGreenLight,
                    .customGreenMedium],
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
        }
    }
}

#Preview {
    CustomBackgroundView()
}
