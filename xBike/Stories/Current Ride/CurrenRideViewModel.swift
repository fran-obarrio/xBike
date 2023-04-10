//
//  CurrenRideViewModel.swift
//  xBike
//
//  Created by Francisco Obarrio on 09/04/2023.
//

import UIKit
import ObjectiveC

class CurrentRideViewModel {
    
    var geoManager: GeoManager?
    var sessionManager = SessionManager.shared
    
    public var isUserRiding: Bool? {
        return geoManager?.startLocation != nil
    }
    
    public var startAddress: String? {
        return geoManager?.startAddress
    }

    public var finalAddress: String? {
        return geoManager?.finalAddress
    }

    public var distanceInKM: String? {
        return geoManager?.distanceInKM
    }
    
    init(geoManager: GeoManager) {
        self.geoManager = geoManager
    }
    
    func saveData(time: String) {
        
        if let distanceInKM = distanceInKM, let startAddress = startAddress, let finalAddress = finalAddress {
            let rideData = RideModel(time: time, distance: distanceInKM, startAddress: startAddress, finalAddress: finalAddress)
            
            if let rideItemsArray = SessionManager.shared.rideData {
                sessionManager.rideData = rideItemsArray + [rideData]
            } else {
                sessionManager.rideData = [rideData]
            }
        }
    }
    
}

