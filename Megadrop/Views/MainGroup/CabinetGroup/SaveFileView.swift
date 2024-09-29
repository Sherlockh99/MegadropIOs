//
//  SaveFileView.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 15.09.2024.
//

import SwiftUI
import UniformTypeIdentifiers
import UIKit

struct SaveFileView: View {
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var fileURL: URL?

    func saveFile(prices: String) {
        let fileName = "price.json"
        let data = prices.data(using: .utf8)

        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileURL = directory?.appendingPathComponent(fileName)

        do {
            if let fileURL = fileURL, let data = data {
                try data.write(to: fileURL)
                self.fileURL = fileURL
                alertMessage = "Saved"
                print("File saved to: \(fileURL.absoluteString)")
            } else {
                alertMessage = "Not Saved"
            }
        } catch {
            alertMessage = "Failed to save: \(error.localizedDescription)"
        }

        showAlert = true
    }

    var body: some View {
        VStack {
            Button(action: {
                let prices = "{\"price\": 100}"
                saveFile(prices: prices)
                
            }) {
                Text("Save Prices")
            }
            
            if let fileURL = fileURL {
                DocumentInteractionView(url: fileURL)
                    .frame(height: 0)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertMessage))
        }
    }
}

// Представление для UIDocumentInteractionController
struct DocumentInteractionView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let documentInteractionController = UIDocumentInteractionController(url: url)
        documentInteractionController.delegate = context.coordinator
        documentInteractionController.presentOptionsMenu(from: viewController.view.frame, in: viewController.view, animated: true)
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, UIDocumentInteractionControllerDelegate {
        func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
            return UIApplication.shared.windows.first?.rootViewController ?? UIViewController()
        }
    }
}

struct SaveFileView_Previews: PreviewProvider {
    static var previews: some View {
        SaveFileView()
    }
}
