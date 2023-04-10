//
//  UIVIew+Extensions.swift
//  xBike
//
//  Created by Francisco Obarrio on 06/04/2023.
//

import UIKit

extension UIView {
        
    func roundedBorder(color: UIColor, width: CGFloat, cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        
    }
    
    func dropShadow(shadowOpacity:Float = 1, cornerRadius:CGFloat = 10.0, shadowOffset: CGSize = CGSize(width: 0, height: 2.0), borderWidth: CGFloat = 1.0, shadowRadius: CGFloat = 3.0) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }
}
