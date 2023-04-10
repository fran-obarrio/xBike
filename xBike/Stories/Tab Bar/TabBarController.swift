//
//  TabBarController.swift
//  xBike
//
//  Created by Francisco Obarrio on 05/04/2023.
//

import Foundation
import UIKit


enum MainTabBarItems: Int, CaseIterable {
    case CurrentRide    = 0
    case MyProgress     = 1
}

class TabBarController: UITabBarController, Storyboarded {
    var currentViewController: UIViewController?
    
    let mainCoordinator = MainCoordinator()
    
    override func viewDidLoad() {
        self.delegate = self
        
        setColorAttributes()
        createShadow()
    }
    
    override func viewWillLayoutSubviews() {
        var tabBarHeight: CGFloat = 90

        if #available(iOS 11.0, *) {
            let bottomPadding = view.safeAreaInsets.bottom
            
            if (bottomPadding == 0) {
                tabBarHeight = 55
            }
        }
        
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = tabBarHeight
        tabFrame.origin.y = self.view.frame.size.height - tabBarHeight
        self.tabBar.frame = tabFrame
    }
    
    func createShadow() {
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        tabBar.layer.shadowRadius = 5
        tabBar.layer.shadowOpacity = 0.17
        tabBar.layer.masksToBounds = false
    }
    
    func setColorAttributes() {
        if #available(iOS 13, *) {
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = .white
            appearance.stackedLayoutAppearance.normal.iconColor = .black
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            appearance.stackedLayoutAppearance.normal.badgeBackgroundColor = .blue
            appearance.stackedLayoutAppearance.selected.iconColor =  .darkGray
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
            
            self.tabBar.standardAppearance = appearance
            
        } else {
            self.tabBar.unselectedItemTintColor = UIColor.black
            self.tabBar.tintColor = UIColor.blue
        }
    }
    
}


extension TabBarController: UITabBarControllerDelegate {
    /// When the user manually taps on a tab bar item and the `shouldSelect` lifecycle
    /// trigger is happening to determine if the `selectedIndex` value should change,
    /// we can hi-jack the function check to see if they are selecting the tab that
    /// is already selected. If so, we will infer that the users intention was to
    /// jump the current scroll view to the top.
    ///
    /// - parameter tabBarController: UITabBarController that is affected by the change
    /// - parameter shouldSelect viewController: UIViewController that will be selected
    ///
    /// NOTE: This is a subclassed function of UITabBarController.
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {


        return true
    }
    
    
    /// When the user manually taps on a tab bar item and the `didSelect` lifecycle
    /// trigger is happening then we can tell which tab was selected and begin
    /// informing relevant observers (e.g. analytics suite).
    ///
    /// - parameter tabBarController: UITabBarController that is affected by the change
    /// - parameter didSelect viewController: UIViewController that was selected
    ///
    /// NOTE: This is a subclassed function of UITabBarController.
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
      
    }
    

}


