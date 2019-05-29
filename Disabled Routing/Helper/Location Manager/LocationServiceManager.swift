//
//  LocationServiceManager.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 24/07/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//
import Foundation
import CoreLocation
import UIKit
protocol LocationUpdateDelegate: class {
    func showControllerWithVC(controller: UIViewController)
    func locationUpdated(lat: Double, long: Double)
    func receivedAddressFromLocation(_ address:String)
}


extension LocationUpdateDelegate
{
    func receivedAddressFromLocation(_ address:String){}
    func showControllerWithVC(controller: UIViewController){}
}
class LocationServiceManager: NSObject, CLLocationManagerDelegate{
    
    static let sharedInstance = LocationServiceManager()
    var currentLocation: CLLocation?
 
    weak var viewDelegate: LocationUpdateDelegate?
    
    private var manager = CLLocationManager()

    private func configureLocationServices(){
        
        self.checkForUserPermissions()
    }
    
    //MARK: Location Manager Delegate
    private func locationManager(manager: CLLocationManager,
                         didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
            manager.delegate = self
        }
        else{
            self.checkForUserPermissions()
        }
    }
    
    func checkForUserPermissions(){
        manager.delegate = self
        
        switch CLLocationManager.authorizationStatus()
        {
        case .authorizedAlways:
        manager.startUpdatingLocation()
            break
        case .notDetermined:
            manager.requestAlwaysAuthorization()
        case .authorizedWhenInUse:
        manager.startUpdatingLocation()
            break
        case .restricted, .denied:
            break
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
       self.currentLocation = locations.last
        self.viewDelegate?.locationUpdated(lat: (self.currentLocation?.coordinate.latitude)!, long: (self.currentLocation?.coordinate.longitude)!)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }

    func sendLocationUpdateForDriver()
    {
        if UserDefaultUtility.retrieveBoolForKey(AppConstants.UserDefaultKeys.IS_ALREADY_LOGIN) && self.currentLocation != nil
        {
            self.viewDelegate?.locationUpdated(lat: (self.currentLocation?.coordinate.latitude)!, long: (self.currentLocation?.coordinate.longitude)!)
        }
    }
    
//    func getFakeGPSCoordinatesFromLocation(location: CLLocation)->CLLocation{
//        let lat = location.coordinate.latitude + 11.0238408
//        let lng = -(180 - location.coordinate.longitude) + 27.9180363
//
//        return CLLocation(latitude: lat, longitude: lng)
//    }
    
}
