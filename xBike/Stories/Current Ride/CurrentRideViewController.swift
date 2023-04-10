//
//  CurrentRideViewController.swift
//  xBike
//
//  Created by Francisco Obarrio on 05/04/2023.
//


import UIKit
import SnapKit
import GoogleMaps

class CurrentRideViewController: UIViewController, CLLocationManagerDelegate {
    
    var coordinator: CurrentRideCoordinator?
    var geoManager = GeoManager.shared
    var mapView: GMSMapView?
    
    private lazy var viewModel: CurrentRideViewModel = {
        let viewModel = CurrentRideViewModel(geoManager: geoManager)
        return viewModel
    }()
    
    lazy var modalStartView: UIModalStartView = {
        let view = UIModalStartView()
        view.delegate = self
        view.tag = 100
        return view
    }()
    
    lazy var modalYourTimeView: UIModalYourTimeView = {
        let view = UIModalYourTimeView()
        view.delegate = self
        view.tag = 200
        return view
    }()
    
    lazy var modalSuccessView: UIModalSuccessView = {
        let view = UIModalSuccessView()
        view.delegate = self
        view.tag = 300
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupMapView()
        setupGeoManager()
        
    }
    
    private func setupMapView() {
        let camera = GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: 17.0)
        let topInset = self.view.safeAreaInsets.top
        
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapView?.padding = UIEdgeInsets(top: topInset, left: 0, bottom: self.view.frame.height / 3, right: 0)
        mapView?.settings.compassButton = true
        mapView?.settings.myLocationButton = true
        
        mapView?.isMyLocationEnabled = true
        
        self.view.insertSubview(mapView!, at: 0)
                        
    }
    
    private func setupGeoManager() {
        if geoManager.isAuthorized() == false {
            geoManager.requestAuthorizationSilently()
        } else {
            if let mapView = mapView {
                geoManager.mapView = mapView
            }
        }
    }
    
    private func setupNavigationBar() {
        navigationBarAddRightButton()
    }
    
    internal func addModalStart() {
        self.view.addSubview(modalStartView)
        modalStartView.snp.makeConstraints { make in
            make.height.equalToSuperview().dividedBy(3.5)
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(-400)
            make.centerX.equalToSuperview()
        }
        modalStartView.resetData()
        
        self.view.layoutIfNeeded()
    }
    
    internal func addModalYourTime() {
        self.view.addSubview(modalYourTimeView)
        modalYourTimeView.snp.makeConstraints { make in
            make.height.equalToSuperview().dividedBy(1.9)
            make.leading.trailing.equalToSuperview().inset(15)
            make.centerY.equalToSuperview().offset(800)
            make.centerX.equalToSuperview()
        }
        self.view.layoutIfNeeded()
    }
    
    internal func addModalSuccess() {
        self.view.addSubview(modalSuccessView)
        modalSuccessView.snp.makeConstraints { make in
            make.height.equalToSuperview().dividedBy(2.3)
            make.leading.trailing.equalToSuperview().inset(15)
            make.centerY.equalToSuperview().offset(800)
            make.centerX.equalToSuperview()
        }
        self.view.layoutIfNeeded()
    }
   
    @objc override func doShowModal() {
        doAnimModalStartFadeIn()
        
        // Disable Plus Button
        toggleButtonEnabled(false)
    }
    
}

extension CurrentRideViewController: UIModalStartDelegate {
    
    func doStartRide() {
        geoManager.startUpdatingLocation()
    }
    
    func doStopRide(time: String) {
        geoManager.stopWalking()
        
        // Modal Data
        modalYourTimeView.distance = geoManager.distanceInKM
        modalYourTimeView.time = time
        
        // Modal Transitions
        doAnimModalStartFadeOff()
        doAnimModalYourTimeFadeIn()
        
    }
}

extension CurrentRideViewController: UIModalYourTimeDelegate {
    func doStoreRide(time: String) {
        viewModel.saveData(time: time)
        
        // Modal Transitions
        doAnimModalYourTimeFadeOff()
        doAnimModalSuccessFadeIn()
        
        geoManager.resetData()
    }
    
    func doDeleteRide() {
        geoManager.resetData()
        
        // Modal Transitions
        doAnimModalYourTimeFadeOff()
        
        // Enable Plus Button
        toggleButtonEnabled(true)
    }
    
}

extension CurrentRideViewController: UIModalSuccessDelegate {
    func doCloseModal() {
        doAnimModalSuccessFadeOff()
        
        // Enable Plus Button
        toggleButtonEnabled(true)
    }
}


