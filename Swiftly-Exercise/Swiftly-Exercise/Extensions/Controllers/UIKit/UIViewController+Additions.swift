//
//  UIViewController+Additions.swift
//  Swiftly-Exercise
//
//  Created by Megan Herold on 2/27/20.
//  Copyright © 2020 Megan Herold. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentOkAlert(title: String = "Error", message: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func presentOkAlert(for error: Error) {
        presentOkAlert(message: error.localizedDescription)
    }
    
}
