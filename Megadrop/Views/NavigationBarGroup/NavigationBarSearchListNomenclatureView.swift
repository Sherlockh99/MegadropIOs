//
//  NavigationBarSearchListNomenclatureView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 21.05.2024.
//

import SwiftUI

struct NavigationBarSearchListNomenclatureView: View {
    // MARK: - PROPERTY
    
    @EnvironmentObject var shop: Shop
    @State private var isAnimated: Bool = false
    // MARK: - BODY
    var body: some View {
        HStack {
            Button(action: {
                withAnimation(.easeIn){
                    feedback.impactOccurred()
                    //shop.selectedProduct = nil
                    //shop.showingProduct = false
                    //shop.selectedNomenclature = nil
                    //shop.showingNomenclature = false
                    //shop.isNomenclatureCatalog = false
                    shop.isGroupCatalog = false
                    shop.isGroupsCatalog = true
                }
            }, label: {
                Image(systemName: "chevron.left")
                    .font(.title)
                    .foregroundColor(.primary)
            })
            
            Spacer()
           
            Text("SEARCH")
              .opacity(isAnimated ? 1 : 0)
              .offset(x: 0, y: isAnimated ? 0 : -25)
              .onAppear(perform: {
                withAnimation(.easeOut(duration: 0.5)) {
                  isAnimated.toggle()
                }
              })
            Spacer()
        } //: HSTACK
    }
}

#Preview {
    NavigationBarSearchListNomenclatureView()
        .environmentObject(Shop())
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color.gray)
}
