//
//  UIViewController+Storyboarded.swift
//  xBike
//
//  Created by Francisco Obarrio on 05/04/2023.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: className, bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}

