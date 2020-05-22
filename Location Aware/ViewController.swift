//
//  ViewController.swift
//  Location Aware
//
//  Created by TrungLD on 5/22/20.
//  Copyright © 2020 TrungLD. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{
    @IBOutlet weak var latitude: UILabel!
    
    @IBOutlet weak var nearestAdress: UILabel!
    @IBOutlet weak var atitude: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var course: UILabel!
    @IBOutlet weak var longtitude: UILabel!
    var manager = CLLocationManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        manager.delegate = self
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       let location = locations[0]
        
        self.latitude.text = String( location.coordinate.latitude)
        self.longtitude.text = String (location.coordinate.longitude)
        self.course.text = String( location.course)
        self.speed.text = String ( location.speed)
        self.atitude.text = String ( location.altitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
            if error != nil {
                print(error)
            } else {
                if let placemark    = placemark?[0]{
                    var address = " "
                    
                    if placemark.subThoroughfare != nil {
                        
                        address += placemark.subThoroughfare! + " "
                        
                    }
                    
                    if placemark.thoroughfare != nil {
                        address += placemark.thoroughfare! + "\n"
                    }
                    
                    if placemark.subLocality != nil {
                        
                                           address += placemark.subLocality! + "\n"
                        
                                       }
                    if placemark.subAdministrativeArea != nil {
                        
                                           address += placemark.subAdministrativeArea! + "\n"
                        
                                       }
                    if placemark.postalCode != nil {
                        
                                           address += placemark.postalCode! + "\n"
                        
                                       }
                    if placemark.country != nil {
                                                            address += placemark.country! + "\n"
                                                        }
                    self.nearestAdress.text = address
                }
            }
        }
        
    }
}

