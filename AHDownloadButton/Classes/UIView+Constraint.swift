//
//  UIView+Constraint.swift
//  AHDownloadButton
//
//  Created by Amer Hukic on 03/09/2018.
//  Copyright © 2018 Amer Hukic. All rights reserved.
//

import UIKit

extension UIView {
    
    func pinToSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: self,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: superview,
                                               attribute: .top,
                                               multiplier: 1,
                                               constant: 0)
        
        let leftConstraint = NSLayoutConstraint(item: self,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: superview,
                                                attribute: .left,
                                                multiplier: 1,
                                                constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(item: self,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: superview,
                                                  attribute: .bottom,
                                                  multiplier: 1,
                                                  constant: 0)
        
        let rightConstraint = NSLayoutConstraint(item: self,
                                                 attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: superview,
                                                 attribute: .right,
                                                 multiplier: 1,
                                                 constant: 0)
        NSLayoutConstraint.activate([topConstraint, leftConstraint, bottomConstraint, rightConstraint])
    }
    
    func centerToSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        let centerXConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: superview,
                                                   attribute: .centerX,
                                                   multiplier: 1,
                                                   constant: 0)
        
        let centerYConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: superview,
                                                   attribute: .centerY,
                                                   multiplier: 1,
                                                   constant: 0)
        NSLayoutConstraint.activate([centerXConstraint, centerYConstraint])
    }
    
}
