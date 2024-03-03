//
//  ContentView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 07.01.2024.
//

import SwiftUI

struct ContentView1: View {

    @State private var authorization: Tab = .dropToApp
    @State private var action: Int? = 0
    let image = Image("logo")
    @State private var showSecondView = false
    @State private var isLinkActive = false
    
    enum Tab {
        case accessToApp
        case dropToApp
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                HStack{
                    Spacer()
                    LogoCircleImage(image: Image("logo"))
                    Spacer()
                }
                
                ProfileLoginView().padding()

                NavigationLink{
                    SecondContentView()
                }label: {
                    Text("fffff")
                }
                
                Button("Нажмите здесь") {
                    // Здесь вызывается ваш алгоритм проверки
                    if checkCondition() {
                        //showSecondView = true
                        self.isLinkActive = true
                    }
                }
                Spacer()
            }
        }
    }
    
    func checkCondition() -> Bool {
        // Здесь реализуйте ваш алгоритм проверки
        // Верните true, если условие выполнено
        return true
    }
}

struct SecondContentView:View {
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}

//#Preview {
//    ContentView()
//}
