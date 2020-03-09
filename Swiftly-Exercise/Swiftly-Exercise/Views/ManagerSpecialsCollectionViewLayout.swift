//
//  ManagerSpecialsCollectionViewLayout.swift
//  Swiftly-Exercise
//
//  Created by Megan Herold on 3/6/20.
//  Copyright © 2020 Megan Herold. All rights reserved.
//

// Source: https://equaleyes.com/blog/2018/05/10/blog-flow-layout/
// MH: I referenced this guide for centering items in a collection view row.

import UIKit

/// This class represents a single row in the `ManagerSpecialsCollectionViewController`.
class ManagerSpecialsCollectionViewRow {
    
    /// An array of attributes corresponding to each view in a `ManagerSpecialsCollectionViewController` row.
    var attributes = [UICollectionViewLayoutAttributes]()
    
    /// Represents the combined with of the views in the row and the padding between them
    var width: CGFloat {
        var width: CGFloat = 0
        attributes.forEach{ width += $0.frame.width }
        width += ManagerSpecialsCollectionViewLayout.padding * CGFloat(attributes.count - 1)
        return width
    }
    
    /// This method calculates the remaining space not filled by views or padding and offsets each attribute in order to center them in the row.
    /// It assumes that the collection view takes up the entire width of the screen.
    func centerAttributes() {
        let remainingSpace = UIScreen.main.bounds.width - width
        var offset = remainingSpace / 2
        for attribute in attributes {
            attribute.frame.origin.x = offset
            offset += attribute.frame.width + ManagerSpecialsCollectionViewLayout.padding
        }
    }
}

/// This class provides the layout for the elements in the `ManagerSpecialsCollectionViewController`.
class ManagerSpecialsCollectionViewLayout: UICollectionViewFlowLayout {
    
    /// Represents the padding between views in the collection
    static var padding: CGFloat = 10
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        
        // Copy the attributes, don't mutate the originals
        guard let copiedAttributes = attributes.map({ $0.copy() }) as? [UICollectionViewLayoutAttributes] else { return nil }
        
        var rows = [ManagerSpecialsCollectionViewRow]()
        var currentRowY: CGFloat = -1

        // Group the attributes by row using their center Y coordinates.
        for attribute in copiedAttributes {
            if currentRowY != attribute.center.y {
                currentRowY = attribute.center.y
                
                let row = ManagerSpecialsCollectionViewRow()
                rows.append(row)
            }
            
            rows.last?.attributes.append(attribute)
        }
        
        // Center the attributes in each row.
        rows.forEach { $0.centerAttributes() }
        return copiedAttributes
    }
}
