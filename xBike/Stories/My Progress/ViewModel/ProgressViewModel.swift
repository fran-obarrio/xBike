//
//  TableViewModel.swift
//  xBike
//
//  Created by Francisco Obarrio on 16/02/2023.
//

import Foundation

class ProgressViewModel {
    
    var sessionManager = SessionManager.shared
    
    public var tableData: [RideModel]  {
        return sessionManager.rideData ?? []
    }

}
