//
//  GeoManager.swift
//  xBike
//
//  Created by Francisco Obarrio on 07/04/2023.
//

import Foundation
import UIKit
import CoreLocation
import GoogleMaps

class GeoManager: NSObject {

    static let shared = GeoManager()
    
    let geoCoder = CLGeocoder()
    let locationManager = CLLocationManager()
    
    var mapView = GMSMapView()
    var polyline = GMSPolyline()
    var startLocation: CLLocation?
    var lastLocation: CLLocation?
    var distanceTraveled: CLLocationDistance = 0
    var startAddress: String = ""
    var finalAddress: String = ""
        
    var distanceInKM: String? {
        let distanceInKm = distanceTraveled / 1000
        let formattedDistance = String(format: "%.2f", distanceInKm)
        return formattedDistance + " KM"
    }

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.activityType = .fitness
    }
    
    func startUpdatingLocation() {
        resetData()
        locationManager.startUpdatingLocation()
    }
    
    func requestAuthorizationSilently() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func requestAuthorization() -> Bool { // returns if it's currently authorized
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return false
        case .denied, .restricted:
            return false
        default:
            return true
        }
    }
    
    func isAuthorized() -> Bool {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        default:
            return false
        }
    }
    
    func cameraMoveToLocation(toLocation: CLLocationCoordinate2D?) {
        if toLocation != nil {
            mapView.camera = GMSCameraPosition.camera(withTarget: toLocation!, zoom: 15)
        }
    }
    
}

extension GeoManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        guard location.horizontalAccuracy > 0 else { return }
        
        if startLocation == nil {
            startLocation = location
            getAddress(for: location) { address in
                print("Started walking at: \(address)")
                self.startAddress = address
            }
        } else {
            distanceTraveled += location.distance(from: lastLocation ?? startLocation!)
        }
        
        // Calculate the distance traveled since the previous location
        if let lastLocation = lastLocation {
            let distance = lastLocation.distance(from: location)
            distanceTraveled += distance
            
            // Create a new path for the polyline
            let path = GMSMutablePath()
            path.add(lastLocation.coordinate)
            path.add(location.coordinate)
            
            // Create a new polyline with the path and add it to the map
            polyline = GMSPolyline(path: path)
            polyline.geodesic = true
            polyline.strokeWidth = 5.0
            polyline.strokeColor = UIColor.orange
            polyline.map = mapView
        }
        
        // Store the current location as the previous location for the next update
        lastLocation = location
        
        // Move Camera
        cameraMoveToLocation(toLocation: location.coordinate)
    }
    
    func removePolyline() {
        mapView.clear()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            // OK
        } else if status == .denied {
            // TODO
        }
        manager.requestLocation()
    }
    
    public func stopWalking() {
        locationManager.stopUpdatingLocation()
        
        if let lastLocation = lastLocation {
            getAddress(for: lastLocation) { address in
                self.finalAddress = address
            }
        }
    }
    
    public func resetData() {
        startLocation = nil
        lastLocation = nil
        distanceTraveled = 0
        startAddress = ""
        finalAddress = ""
        
        removePolyline()        
    }

    private func getAddress(for location: CLLocation, completion: @escaping (String) -> Void) {
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(location.coordinate) { response, error in
            if let address = response?.firstResult(), let lines = address.lines {
                completion(lines.joined(separator: ", "))
            } else {
                completion("Unknown location")
            }
        }
    }
    
}


