//
//  TabBarController.swift
//  MealsProject
//
//  Created by Kato on 7/12/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit
import CoreLocation

class TabBarController: UITabBarController {
    
    let locationManager = CLLocationManager()
    
    var fireBaseUser = ""
    var userEmail = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self

        // Do any additional setup after loading the view.
        
        if isKeyPresentInUserDefaults(key: "UserSelectedIndex") {
            self.selectedIndex = UserDefaults.standard.integer(forKey: "UserSelectedIndex")
        }
        else {
            self.selectedIndex = 1
        }
        
        checkLocationServiceEnabled()
        
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    private func checkLocationServiceEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkAuthorizationStatus()
        } else {
        }
    }
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    private func checkAuthorizationStatus() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .authorizedAlways:
            break
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        @unknown default:
            fatalError()
        }
    }
    
}


extension TabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        UserDefaults.standard.set(tabBarController.selectedIndex, forKey: "UserSelectedIndex")
       // print(#function)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        //print(fromVC)
        //print(toVC)
        
        return nil
    }
    
}

extension TabBarController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
    }
}
