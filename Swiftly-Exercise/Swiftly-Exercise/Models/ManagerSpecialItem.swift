//
//  ManagerSpecialItem.swift
//  Swiftly-Exercise
//
//  Created by Megan Herold on 2/27/20.
//  Copyright © 2020 Megan Herold. All rights reserved.
//

import Foundation

struct ManagerSpecialItem: Codable {
    
    /// The name of this item
    let displayName: String
    
    /// The height of the tile for this item, measured in `canvasUnit`s
    let height: Int
    
    /// The URL for the image of this item
    let imageUrl: String
    
    /// The original price for this item
    let originalPrice: String
    
    /// The special price for this item
    let price: String
    
    /// The width of the tile for this item, measured in `canvasUnit`s
    let width: Int
    
    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case height 
        case imageUrl
        case originalPrice = "original_price"
        case price
        case width
    }
}
