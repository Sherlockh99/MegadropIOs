//
//  HeaderDetailView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 16.03.2024.
//

import SwiftUI

struct HeaderDetailView: View {
    
    // MARK: - PROPERTY
    
    @EnvironmentObject var shop: Shop
    
    // MARK: - BODY

    var body: some View {
        VStack(alignment: .leading, spacing: 6, content: {
          Text("Protective Gear")
          
          Text(shop.selectedProduct?.name ?? sampleProduct.name)
            .font(.largeTitle)
            .fontWeight(.black)
            
            Text(shop.selectedNomenclature?.Nomenclature ?? sampleProduct.name)
                .font(.largeTitle)
                .fontWeight(.black)

        }) //: VSTACK
        .foregroundColor(.white)
    }
}

#Preview {
    HeaderDetailView()
        .environmentObject(Shop())
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color.gray)
}
