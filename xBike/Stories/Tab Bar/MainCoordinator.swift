//
//  MainCoordinator.swift
//  xBike
//
//  Created by Francisco Obarrio on 05/04/2023.
//

import Foundation
import UIKit

class MainCoordinator: NSObject, Coordinator {
    public var childCoordinators = [Coordinator]()
    public var navigationController: BaseNavigationViewController?
    public var tabBarController: TabBarController?
    
    
    fileprivate let currentRideCoordinator = CurrentRideCoordinator()
    fileprivate let progressCoordinator = ProgressCoordinator()
    
    fileprivate var coordinators: [Coordinator] {
        return [currentRideCoordinator, progressCoordinator]
    }
    
    func start() {
        DispatchQueue.main.async {
            if SessionManager.shared.hasShowOnBoardingFlow != nil {
                self.startRoot()
            } else {
                self.doOnBoarding()
            }
        }
    }
    
    private func doOnBoarding() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "OnBoardingViewController") as? OnBoardingViewController {
            vc.coordinator = self
            navigationController = BaseNavigationViewController(rootViewController: vc)
            navigationController?.showAsRoot()
        }
    }
    
    private func startRoot() {
        // Create the UITabBarController and place it within a NavigationController
        tabBarController = TabBarController.instantiate()
        navigationController = BaseNavigationViewController(rootViewController: tabBarController!)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.showAsRoot()
        
        
        var controllers: [UIViewController] = []
        for coordinator in coordinators {
            coordinator.start()
            controllers.append(coordinator.navigationController!)
        }
        
        tabBarController?.viewControllers = controllers
        
    }
    
    public func gotoCurrentRideTab() {
        tabBarController?.selectedIndex = 0
    }
    
    public func gotoProgressTab() {
        tabBarController?.selectedIndex = 1
    }
    
    
    public func getCurrentSelectedTab() -> String {
        if let tabController = tabBarController {
            if tabController.selectedIndex == MainTabBarItems.CurrentRide.rawValue {
                return "TabCurrentRide".localized
            } else if tabController.selectedIndex == MainTabBarItems.MyProgress.rawValue {
                return "TabMyProgress".localized
            } else {
                return ""
            }
        } else {
            return ""
        }
    }
    
    public func getCurrentCoordinator() -> Coordinator? {
        if let index = self.tabBarController?.selectedIndex {
            return coordinators[index]
        } else {
            return nil
        }
    }
    
    func closeOnBoarding() {
        DispatchQueue.main.async {
            self.startRoot()
        }
        
        // Update OnBoarding flag
        SessionManager.shared.hasShowOnBoardingFlow = true
    }
}
