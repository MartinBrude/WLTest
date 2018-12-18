//
//  MKMapKitExtension.swift
//  WLTest
//
//  Created by Martin on 21/12/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Foundation
import MapKit

extension MKMapView {
    func centerMap(location: CLLocation, radius : CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: radius, longitudinalMeters: radius)
        setRegion(coordinateRegion, animated: true)
    }

    func addAnnotations(pois : [POI]) {
        var annotations = [MKPointAnnotation]()
        pois.forEach({ (poi) in
            if let geocoordinates = poi.geocoordinates, let coordinate = LocationHelper.location(geocoordinates: geocoordinates)?.coordinate {
                let annotation = MKPointAnnotation()
                annotation.title = poi.title
                annotation.coordinate = coordinate
                annotations.append(annotation)
            }
        })
        addAnnotations(annotations)
    }
}


