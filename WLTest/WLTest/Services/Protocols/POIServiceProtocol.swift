//
//  POIServiceProtocol.swift
//  WLTest
//
//  Created by Martin on 18/12/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Foundation

protocol POIServiceProtocol {
    func getPois(successful: @escaping ([POI]) -> (), failure: @escaping (String?) -> ())
    func getPoiDetail(poiId : String, successful: @escaping (POIDetail) -> (), failure: @escaping (String?) -> ())
    func search(text : String) -> [POI]
}
