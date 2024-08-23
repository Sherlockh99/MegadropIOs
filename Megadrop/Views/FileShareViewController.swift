//
//  FileShareViewController.swift
//  Megadrop
//
//  Created by Андрій Коробчук on 24.08.2024.
//

import Foundation
import UIKit

class FileShareViewController: UIViewController {
    var fileURL: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let fileURL = fileURL {
            let documentInteractionController = UIDocumentInteractionController(url: fileURL)
            documentInteractionController.delegate = self
            documentInteractionController.presentOptionsMenu(from: self.view.frame, in: self.view, animated: true)
        }
    }
}

extension FileShareViewController: UIDocumentInteractionControllerDelegate {
    // Реализуйте методы делегата, если нужно
}
