//
//  LocationHelper.swift
//  WLTest
//
//  Created by Martin on 21/12/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Foundation
import MapKit

class LocationHelper {

    static func location(geocoordinates : String) -> CLLocation? {
        let geoCoords = geocoordinates.split(separator: ",")
        if let lat = geoCoords.first, let long = geoCoords.last  {
            let latitudeString = String(lat)
            let longitudeString = String(long)
            return CLLocation(latitude: (latitudeString as NSString).doubleValue, longitude: (longitudeString as NSString).doubleValue)
        }
        return nil
    }
}
