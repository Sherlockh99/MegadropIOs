//
//  NomenclatureView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 10.02.2024.
//

import SwiftUI

struct NomenclatureView: View {
    @State var nomenclature: Nomenclature2
    @State private var value = 0
    //var nomenclature: Nomenclature2
    
    var image: Image{
        Image("logo")
    }
    
    var body: some View {
        //NavigationSplitView{
            ScrollView {
                VStack{
                    if(nomenclature.Image != ""){
                        ImageViewer(imageModel: ImageModel(imageDataString: nomenclature.Image!))
                    }else{
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 300)
                    }
                    
                    Text(nomenclature.Nomenclature)
                    
                    HStack{
                        Text("Артикул:")
                        Text(nomenclature.VendorCode)
                        Spacer()
                        Text("Доступно:")
                        if(nomenclature.Available) {
                            Text("Да")
                        }else {
                            Text("Нет")
                        }
                    }
                    
                    if let details = nomenclature.Details{
                        Text(details)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading) // Растягиваем по ширине и выравниваем текст влево
                            .multilineTextAlignment(.leading) // Выравнивание многострочного текста влево
                            .padding() // Добавляем отступы для лучшего визуального восприятия
                    }
                
                    
                    if(nomenclature.Characteristics != nil){
                        if let characteristics = nomenclature.Characteristics {
                            ForEach(characteristics) { characteristic in
                                VStack(alignment: .leading) {
                                    Text(characteristic.Characteristic)
                                        .font(.headline)
                                    VStack {
                                        Text("Цена: \(characteristic.Price, specifier: "%.2f")")
                                        HStack {
                                            
                                            //Text("Количество: \(characteristic.OrderedQuality, specifier: "%.2f")")
                                            LazyVStack {
                                                Stepper("Количество: \(value)", value: $value)
                                                    //.padding()
                                            }
                                            //Spacer()
                                        
                                        }
                                    }
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                }
                            }
                        }
                    }

                    /*
                    NavigationLink{
                        BasketView()"f"                    }label: {
                        Text("Перейти в корзину")
                    }
                     */
                    
                    Button{
                        //isShowNewView = checkCondition()
                        /*
                        getDataNomenclature(nomenclature: nomenclature) {
                            modified in
                            nomenclature.Details = modified.Details
                            nomenclature.Image = modified.Image
                        
                        let a=1
                        }
                        */
                    } label: {
                        HStack{
                            Spacer()
                            Text("Сохранить картинку")
                            Spacer()
                        }
                    }
                
                    HStack{
                        Button{
                            //isShowNewView = checkCondition()
                        } label: {
                            HStack{
                                Spacer()
                                Text("Скопировать описание")
                                Spacer()
                            }
                        }
                        
                        Button{
                            //isShowNewView = checkCondition()
                        } label: {
                            HStack{
                                Spacer()
                                Text("Отправить описание")
                                Spacer()
                            }
                        }
                    }
                
                }
            }
            .padding()
            .font(.system(.title2, design: .rounded, weight: .bold))
            .onAppear{
                getDataNomenclature(nomenclature: nomenclature) {
                    modified in
                    nomenclature.Details = modified.Details
                    nomenclature.Image = modified.Image
                    nomenclature.Characteristics = modified.Characteristics
                }
                
            }
    }
}

#Preview {
    NomenclatureView(nomenclature: ModelData().groupsWithNomenclatures[0].Nomenclatures[0])
}
