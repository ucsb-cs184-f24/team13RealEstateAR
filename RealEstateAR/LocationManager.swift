//
//  LocationManager.swift
//  RealEstateAR
//
//  Created by Animesh on 11/10/24.
//

import SwiftUI
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    
    @Published var userLatitude: Double = 0.0
    @Published var userLongitude: Double = 0.0
    @Published var userHeading: Double = 0.0
    @Published var locationStatus: CLAuthorizationStatus?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // Set accuracy to best
        locationManager.requestWhenInUseAuthorization() // Request "When in Use" authorization
        locationManager.startUpdatingLocation() // Start updating location
        locationManager.startUpdatingHeading() // Start updating heading
    }
    
    // Handle location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        // Update the coordinates
        userLatitude = location.coordinate.latitude
        userLongitude = location.coordinate.longitude
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading heading: CLHeading) {
        userHeading = heading.trueHeading
    }
    
    // Handle authorization status changes
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationStatus = manager.authorizationStatus
    }
    
    // Handle location errors
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
}
