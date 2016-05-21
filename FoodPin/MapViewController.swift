//
//  MapViewController.swift
//  FoodPin
//
//  Created by Leonardo Lobato on 5/21/16.
//  Copyright © 2016 Leonardo Lobato. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate{
    
    @IBOutlet var mapView:MKMapView!
    var restaurant:Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.showsCompass = true
        mapView.showsTraffic = true
        mapView.showsScale = true
    
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location,completionHandler: {
            placemarks, error in
            if error != nil {
                print(error)
                return
            }
            
            if let placemarks = placemarks{
                let placemark = placemarks[0]
                
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurant.name
                annotation.subtitle = self.restaurant.type
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
        })
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        
        if annotation.isKindOfClass(MKUserLocation) {
            return nil
        }
        
        var annotationView:MKPinAnnotationView? = mapView
            .dequeueReusableAnnotationViewWithIdentifier(identifier) as?
            MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation,
                                                 reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        let leftIcoonView = UIImageView(frame: CGRectMake(0, 0, 53, 53))
        leftIcoonView.image = UIImage(named: restaurant.image)
        annotationView?.leftCalloutAccessoryView = leftIcoonView
        
        return annotationView
    }
    

}
