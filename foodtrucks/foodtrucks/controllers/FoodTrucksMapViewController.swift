//
//  FoodTrucksMapViewController.swift
//  foodtrucks
//
//  Created by darshan on 6/1/19.
//  Copyright © 2019 darshan. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class FoodTrucksMapViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapview: MKMapView!
    var foodtrucksInfo : Array<FoodTrucks> = []
    let locationManager = CLLocationManager()
    @IBAction func showListController(_ sender: Any) {
        self.dismiss(animated: true) {
            // don't do anything
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = (manager.location?.coordinate)!
        print(locValue)
    }
    
    func askLocationPermission() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        let alert = UIAlertController(title: "Settings", message: "Allow location from settings", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Goto Settings", style: UIAlertAction.Style.default) { action in
            switch action.style{
            case .default: UIApplication.shared.openURL(NSURL(string: UIApplication.openSettingsURLString)! as URL)
            case .cancel: print("cancel")
            case .destructive: print("destructive")
            }
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //askLocationPermission()
        pinLocations()
    }

    func setScalingFactor(coordinate : CLLocationCoordinate2D) {
        let miles = 7.0;
        let scalingFactor = abs((cos(2 * Double.pi * coordinate.latitude / 360.0) ));
        var span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        span.latitudeDelta = miles/69.0;
        span.longitudeDelta = miles/(scalingFactor * 69.0);
        
        var region = MKCoordinateRegion(
            center: CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude), latitudinalMeters: 11265.4, longitudinalMeters: 11265.4)
        region.span = span;
        region.center = coordinate;
        
        mapview .setRegion(region, animated: true)
    }
    
    func pinLocations() {
        setScalingFactor(coordinate: CLLocationCoordinate2D(latitude: 37.787407398506105, longitude: -122.40741302567949)) // just going to set it to SF
        for foodtruck in foodtrucksInfo {
            let truck = MKPointAnnotation()
            truck.coordinate = CLLocationCoordinate2D(latitude: Double(foodtruck.trucks[0].latitude ?? "37.787407398506105") ?? 37.787407398506105, longitude: Double(foodtruck.trucks[0].longitude ?? "-122.40741302567949") ?? -122.40741302567949)
            print(truck.coordinate)
            mapview.addAnnotation(truck)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
