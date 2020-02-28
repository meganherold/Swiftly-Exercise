//
//  ViewController.swift
//  Swiftly-Exercise
//
//  Created by Megan Herold on 2/27/20.
//  Copyright © 2020 Megan Herold. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var layout: ManagerSpecialLayout?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestLayout()
    }
    
    func requestLayout() {
        guard let url = ManagerSpecialLayout.Endpoint.url else {
            presentOkAlert(message: "Invalid URL ⁉️")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                self?.presentOkAlert(for: error)
                return
            }
            
            if let data = data {
                if let decodedLayout = try? JSONDecoder().decode(ManagerSpecialLayout.self, from: data) {
                    self?.layout = decodedLayout
                    self?.presentOkAlert(title: "Success!", message: "Decoded the layout 🎉")
                } else {
                    self?.presentOkAlert(message: "Failed to decode the layout ☹️")
                }
            } 
        }.resume()
        
    }

}

