//
//  UIViewController+Extensions.swift
//  xBike
//
//  Created by Francisco Obarrio on 05/04/2023.
//

import Foundation
import UIKit

public protocol RootShowable: AnyObject {
    func showAsRoot()
}

extension RootShowable where Self: UIViewController {
    
    public func showAsRoot() {
        guard let window = window else {
            return
        }
        
        window.rootViewController = self
        window.makeKeyAndVisible()
    }
}

extension UIViewController: RootShowable {
    
    public var window: UIWindow? {
        var appWindow = view.window
        if appWindow == nil {
            if UIApplication.shared.windows.count > 0 {
                appWindow = UIApplication.shared.windows[0]
            }
        }
        return appWindow
    }
    
    
    public var contentViewController: UIViewController? {
        if let navigationViewController = self as? BaseNavigationViewController {
            return navigationViewController.topViewController?.contentViewController
        } else {
            return self
        }
    }
    
    func topBorder(with color:UIColor? = nil) {
        let border:UIView = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(border)
        
        border.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        border.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        border.heightAnchor.constraint(equalToConstant: 1).isActive = true
        if #available(iOS 11.0, *) {
            border.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            border.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        }
    }
    
    @objc func doShowModal(){
        if let nvc = self.navigationController, nvc.viewControllers.count > 1 {
            nvc.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func navigationBarAddRightButton() {
        
        self.title = "CurrenTimeNavigationTitle".localized
        self.navigationController?.isNavigationBarHidden = false
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .orange
        appearance.titleTextAttributes = [.font: UIFont(name: "Abel-Regular", size: 18)!, .foregroundColor: UIColor.white]
        
        // Customizing our navigation bar
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        self.navigationController?.navigationBar.isTranslucent = false
        
        
        // Right button
        let btnRightMenu: UIButton = UIButton()
        btnRightMenu.tag = 99
        btnRightMenu.setImage(UIImage(named: "icons8-plus"), for: .normal)
        btnRightMenu.addTarget(self, action: #selector(doShowModal), for: .touchUpInside)
        btnRightMenu.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnRightMenu.contentHorizontalAlignment = .right
        
        let barButton = UIBarButtonItem(customView: btnRightMenu)
        self.navigationItem.rightBarButtonItem = barButton
        
        
    }
    
    func navigationBarOrange() {
        
        self.title = "ProgressNavigationTitle".localized
        self.navigationController?.isNavigationBarHidden = false
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .orange
        appearance.titleTextAttributes = [.font: UIFont(name: "Abel-Regular", size: 18)!, .foregroundColor: UIColor.white]
        
        // Customizing our navigation bar
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        self.navigationController?.navigationBar.isTranslucent = false
        
        
    }
    
    func toggleButtonEnabled(_ enabled: Bool) {
        if let button = navigationItem.rightBarButtonItem?.customView?.viewWithTag(99) as? UIButton {
            button.isEnabled = enabled
        }
    }
}

