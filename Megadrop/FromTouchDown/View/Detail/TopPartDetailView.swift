//
//  TopPartDetailView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 16.03.2024.
//

import SwiftUI

struct TopPartDetailView: View {

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
                Text("Цена")
                    .fontWeight(.semibold)
            
                Text(shop.selectedNomenclature?.formattedPrice ?? sampleProduct.formattedPrice)
                    .font(.title2)
                    .fontWeight(.black)
                    .scaleEffect(1.35, anchor: .leading)

            })
            .offset(y: isAnimating ? -50 : -75)
          
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
                    //.offset(y: isAnimating ? 0 : -35)
                //Text("Загрузка...")
            }
            
            /*
          // PHOTO
          Image(shop.selectedProduct?.image ?? sampleProduct.image)
            .resizable()
            .scaledToFit()
            .offset(y: isAnimating ? 0 : -35)
           
            if let nomenclature = shop.selectedNomenclature {
                if(nomenclature.Image != ""){
                    ImageViewer(imageModel: ImageModel(imageDataString: nomenclature.Image!))
                        .scaledToFit()
                        .offset(y: isAnimating ? 0 : -35)
    
                }else{
                    image
                        .resizable()
                        .scaledToFit()
                        .offset(y: isAnimating ? 0 : -35)
                }
            } else {

                image
                    .resizable()
                    .scaledToFit()
                    .offset(y: isAnimating ? 0 : -35)
               
            }
             */
            
            
            
        }) //: HSTACK
        .onAppear{
            withAnimation(.easeOut(duration: 0.75)) {
              isAnimating.toggle()
            }
            if let IDNomenclature = shop.selectedNomenclature?.IDNomenclature {
                imageLoader.loadImageData(idNomenclature: IDNomenclature)
            }
        }
    }
}

#Preview {
    TopPartDetailView()
        .environmentObject(Shop())
        .previewLayout(.sizeThatFits)
        .padding()
}
