//
//  Constants.swift
//  WLTest
//
//  Created by Martin on 18/12/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Foundation
import MapKit

struct NetworkingConstants {
    private init () { }
    static let baseUrl = Bundle.main.infoDictionary?["API"] as! String
    static let points = "points"
}

struct Storyboards {
    private init() {}
    static let Main = "Main"
    static let DetailSegue = "detail"
}

struct Texts {
    private init() {}
    static let defaultTitle = "Touristic Spots"
    static let errorTitle = "Something went wrong"
    static let errorFetchingPois = "We couldn't bring the POis for this spot."
    static let errorFetchingPoiDetail = "We couldn't bring the detail for this spot."
    static let errorNoInternet = "There is no internet connection available."
    static let ok = "OK"
    static let reset = "Reset"
}

struct Map {
    static let closeRegionRadius : CLLocationDistance = 800
    static let farRegionRadius : CLLocationDistance = 10000

}

