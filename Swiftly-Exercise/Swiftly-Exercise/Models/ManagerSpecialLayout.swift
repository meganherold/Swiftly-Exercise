//
//  ManagerSpecialLayout.swift
//  Swiftly-Exercise
//
//  Created by Megan Herold on 2/27/20.
//  Copyright © 2020 Megan Herold. All rights reserved.
//

import Foundation

struct ManagerSpecialLayout: Codable {
    
    /// The number of grid units that fit across the width of the screen for this layout.
    let canvasUnit: Int
    
    /// The list of items on Manager Special to be displayed in this layout.
    let managerSpecials: [ManagerSpecialItem]
}
