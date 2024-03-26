//
//  NavigationBarDetailView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 16.03.2024.
//

import SwiftUI

struct NavigationBarDetailView: View {
    
    // MARK: - PROPERTY
    
    @EnvironmentObject var shop: Shop
      
    // MARK: - BODY
    var body: some View {
        HStack {
            Button(action: {
                withAnimation(.easeIn){
                    feedback.impactOccurred()
                    shop.selectedProduct = nil
                    shop.showingProduct = false
                }
            }, label: {
                Image(systemName: "chevron.left")
                    .font(.title)
                    .foregroundColor(.white)
            })
            
            Spacer()
            
            Button(action:{},label: {
                Image(systemName: "cart")
                    .font(.title)
                    .foregroundColor(.white)
            })
        } //: HSTACK
    }
}

#Preview {
    NavigationBarDetailView()
        .environmentObject(Shop())
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color.gray)
}
