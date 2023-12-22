//
//  LocationViewModel.swift
//  Assignment 5
//
//  Created by SENTIENTGEEKS on 21/12/23.
//

import Foundation
import CoreLocation

class LocationViewModel : NSObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    var didUpdateLocation : ((CLLocation)->Void)?
    
    override init() {
        super.init()
        setUpLocationManager()
    }
    private func setUpLocationManager(){
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    //MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            didUpdateLocation?(location)
            stopUpdatingLocation()
        }
    }
    
    private func locationManager(_ manager : CLLocationManager, didFaildWithError error : Error) {
        print("Location manager error: \(error.localizedDescription)")
    }
    func stopUpdatingLocation() {
            locationManager.stopUpdatingLocation()
    }
}
