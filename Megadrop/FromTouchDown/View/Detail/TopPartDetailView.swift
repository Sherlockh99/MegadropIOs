//
//  TopPartDetailView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 16.03.2024.
//

import SwiftUI

struct TopPartDetailView: View {
    let IDGroup: String
    // MARK: - PROPERTY
    
    @EnvironmentObject var shop: Shop
    @State private var isAnimating: Bool = false
    @StateObject private var imageLoader = ImageLoader()


    var image: Image{
        Image("logo")
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 6, content: {
          // PRICE
            VStack(alignment: .leading, spacing: 6, content: {
                /*
                Text("Цена")
                    .fontWeight(.semibold)
            
                if let formattedPrice = shop.selectedNomenclature?.formattedPrice{
                    Text(formattedPrice)
                        .font(.title2)
                        .fontWeight(.black)
                        .scaleEffect(1.35, anchor: .leading)
                        .padding(.bottom, 5)
                }else{
                    Text(sampleProduct.formattedPrice)
                        .font(.title2)
                        .fontWeight(.black)
                        .scaleEffect(1.35, anchor: .leading)
                        .padding(.bottom, 5)
                }
                    */
                Text(shop.selectedNomenclature?.Nomenclature ?? sampleProduct.name)
                    .font(.title2)
                    .fontWeight(.black)
                Text("Артикул: " + (shop.selectedNomenclature?.VendorCode ?? "777"))
                    .fontWeight(.semibold)
            })
            //.offset(y: isAnimating ? -50 : -75)
          
            Spacer()

            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .frame(width: 150, height: 150, alignment: .center)
            } else {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150, alignment: .center)

            }
        }) //: HSTACK
        .onAppear{
            withAnimation(.easeOut(duration: 0.75)) {
              isAnimating.toggle()
            }
            if let IDNomenclature = shop.selectedNomenclature?.IDNomenclature {
                if let selectedNomenclature = shop.selectedNomenclature {
                    if selectedNomenclature.Image == "" {
                        imageLoader.loadImageData(idNomenclature: IDNomenclature)
                        
                        getPicturesNomenclature(nom1: shop.selectedNomenclature!) {
                            modified in
                            if let im = modified.Image{
                                shop.selectedNomenclature?.Image = im
                                
                                GroupManager.shared.updateImageNomenclature(groupID: IDGroup, nomenclatureID: shop.selectedNomenclature!.IDNomenclature, newImage: im)
                                
                            }
                        }
                    }else{
                        imageLoader.decodeImage(fromBase64: selectedNomenclature.Image!)
                    }

                }
            }
        }
    }
}

#Preview {
    TopPartDetailView(IDGroup: ModelData().groupsWithNomenclatures[0].IDGroup)
        .environmentObject(Shop())
        .previewLayout(.sizeThatFits)
        .padding()
}
