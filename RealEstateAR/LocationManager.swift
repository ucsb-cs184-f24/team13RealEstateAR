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
    @Published var userAddress: String = "Searching for address..." // New property

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
    
    // Handle location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        userLatitude = location.coordinate.latitude
        userLongitude = location.coordinate.longitude
        
        // Reverse geocode to get the address
        lookUpCurrentLocation { placemark in
            if let placemark = placemark {
                self.userAddress = "\(placemark.subThoroughfare ?? "") \(placemark.thoroughfare ?? ""), \(placemark.subLocality ?? ""), \(placemark.administrativeArea ?? "") \(placemark.postalCode ?? "")"
            } else {
                self.userAddress = "Address not found"
            }
        }
    }
    
    // Reverse geocoding function
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?) -> Void) {
        if let lastLocation = self.locationManager.location {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(lastLocation) { (placemarks, error) in
                if error == nil, let firstPlacemark = placemarks?.first {
                    completionHandler(firstPlacemark)
                } else {
                    completionHandler(nil)
                }
            }
        } else {
            completionHandler(nil)
        }
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
