//
//  SessionManager.swift
//  xBike
//
//  Created by Francisco Obarrio on 09/04/2023.
//

import UIKit
import Foundation
import ObjectiveC

class SessionManager {
    
    static let shared = SessionManager()

    var rideItems = "rideItems"
    
    var hasShowOnBoardingFlow: Bool? {
        set {
            UserDefaults.standard.set(newValue, forKey: "hasShowOnBoardingFlow")
        }
        
        get {
            return UserDefaults.standard.value(forKey: "hasShowOnBoardingFlow") as? Bool
        }
    }
    
    var rideData: [RideModel]? {
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: rideItems)
        }
        
        get {
            if let data = UserDefaults.standard.value(forKey: rideItems) as? Data {
                return try? PropertyListDecoder().decode([RideModel].self, from: data)
            }
            
            return nil
        }
    }
    
}

