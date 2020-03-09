//
//  UIView+Additions.swift
//  Swiftly-Exercise
//
//  Created by Megan Herold on 3/8/20.
//  Copyright © 2020 Megan Herold. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Call this method on a view to deactivate any constraints it owns involving another view.
    func deactivateConstraints(involving view: UIView) {
        for constraint in self.constraints {
            if let constrainedView = constraint.firstItem as? UIView, constrainedView == view {
                NSLayoutConstraint.deactivate([constraint])
            }
            
            if let constrainedView = constraint.secondItem as? UIView, constrainedView == view {
                NSLayoutConstraint.deactivate([constraint])
            }
        }
    }
    
}
