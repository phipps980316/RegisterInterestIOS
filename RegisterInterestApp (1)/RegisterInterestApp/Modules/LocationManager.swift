//
//  LocationManager.swift
//  RegisterInterestApp
//
//  Created by Jon Phipps on 03/03/2020.
//  Copyright © 2020 Jon Phipps. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

//Class to manage all of the location requests
class LocationManager: CLLocationManager, CLLocationManagerDelegate{
    
    //variable to hold the current device location which will be updated everytime the location changes
    private var deviceLocation = CLLocationCoordinate2D(latitude: 0,longitude: 0)
    
    //Constructor to set up the location manager and to start checking if the location is changing if the device has location services enabled and the application has permission to assess the location data
    override init() {
        super.init()
        if CLLocationManager.locationServicesEnabled(){
            delegate = self
            desiredAccuracy = kCLLocationAccuracyBest
            checkLocationAuth()
        }
    }
    
    //Function to update the device location variable everytime the device's location changes
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        deviceLocation = location
    }
    
    //Function to check if the applications authorization to check the device location has changed
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuth()
    }
    
    //Function to determine what type of authorization the application has and carrys out different actions depending on the authorization given
    func checkLocationAuth(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startUpdatingLocation()
            break
        case .denied:
            break
        case .notDetermined:
            requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .authorizedAlways:
            startUpdatingLocation()
            break
        default:
            break
        }
    }
    
    //Function to return the device location when called
    public func getDeviceLocation() -> CLLocationCoordinate2D{
        return self.deviceLocation
    }
    
    //Function to set up a map region based on supplied coordinates
    public func getMapRegion(latitude: Double, longitude: Double) -> MKCoordinateRegion {
        let latitudeDeg = CLLocationDegrees(latitude)
        let longitudeDeg = CLLocationDegrees(longitude)
        let regionMeters = 0.025
        
        let center = CLLocationCoordinate2DMake(latitudeDeg, longitudeDeg)
        let span = MKCoordinateSpan.init(latitudeDelta: regionMeters, longitudeDelta: regionMeters)
        let region = MKCoordinateRegion.init(center: center, span: span)
        return region
    }
}
