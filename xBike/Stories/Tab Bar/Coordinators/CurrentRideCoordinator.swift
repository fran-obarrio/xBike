//
//  CurrentRideCoordinator.swift
//  xBike
//
//  Created by Francisco Obarrio on 05/04/2023.
//

import Foundation
import UIKit

class CurrentRideCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: BaseNavigationViewController?
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "CurrentRideViewController") as? CurrentRideViewController {
            vc.coordinator = self
            navigationController = BaseNavigationViewController(rootViewController: vc)
            setupTabBarItem(viewController: navigationController!)
        }
        
    }
    
    func setupTabBarItem(viewController: UIViewController) {
        viewController.tabBarItem = UITabBarItem(title: "TabCurrentRide".localized, image: UIImage.init(named: "tabBarRide"), selectedImage: UIImage.init(named: "tabBarRide"))
        viewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: 1, right: 0)
        viewController.tabBarItem.badgeColor = UIColor(red: 232/255, green: 31/255, blue: 74/255, alpha: 1.0)
        
    }
    
}
