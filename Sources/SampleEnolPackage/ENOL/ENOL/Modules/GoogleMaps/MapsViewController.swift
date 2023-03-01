//
//  MapsViewController.swift
//  ENOL
//
//  Created by TVPC000013 on 16/02/23.
//

import UIKit
import GoogleMaps
import CoreLocation

protocol currentLocation{
    func currentLocWithLatLong(lat: Double, Long: Double)
}

class MapsViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    var locationManager = CLLocationManager()
    var del : currentLocation? = nil
    
    var latitude = Double()
    var longitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.settings.compassButton = true
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        getCurrentLocation()
    }
    
    func getCurrentLocation(){
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    @IBAction func backButton_Tapped(_ sender: UIButton){
//        self.del?.currentLocWithLatLong(lat: latitude, Long: longitude)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneButton_Tapped(_ sender: UIButton){
        self.del?.currentLocWithLatLong(lat: latitude, Long: longitude)
        self.navigationController?.popViewController(animated: true)
    }

}
extension MapsViewController {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue : CLLocationCoordinate2D = manager.location?.coordinate else {return}
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.latitude = locValue.latitude
        self.longitude = locValue.longitude
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        marker.title = "Location"
        marker.snippet = "\(locValue.longitude) \(locValue.latitude)"
        marker.map = mapView
    }
}
