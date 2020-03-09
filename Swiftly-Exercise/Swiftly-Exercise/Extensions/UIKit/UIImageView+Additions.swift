//
//  UIImageView+Additions.swift
//  Swiftly-Exercise
//
//  Created by Megan Herold on 3/8/20.
//  Copyright © 2020 Megan Herold. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /// Loads data from a url and if it is an image, assigns it to the `UIImageView`.
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
}
