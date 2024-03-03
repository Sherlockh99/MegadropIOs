//
//  ContentViewTest.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 03.03.2024.
//

import SwiftUI

struct ContentViewTest: View {
    @StateObject var loader = DataLoader()

    var body: some View {
        List(loader.dataList){ dataItem in
            VStack(alignment: .leading)
            {
                Text(dataItem.Nomenclatures[0].Nomenclature)
            }
        }
        .onAppear() {
            loader.loadData()
        }
    }
}


#Preview {
    ContentViewTest()
}
