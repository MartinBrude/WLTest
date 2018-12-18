//
//  JSONParser.swift
//  WLTest
//
//  Created by Martin on 18/12/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Foundation
import Alamofire

class JSONParser {
    static func parsePOI(response : DataResponse<Any>) -> [POI]? {
         return JSONParser.parse(response: response, POIs.self)?.list
    }

    static func parsePOIDetail(response : DataResponse<Any>) -> POIDetail? {
        return JSONParser.parse(response: response, POIDetail.self)
    }

    static func parse<T>(response : DataResponse<Any>, _ type: T.Type) -> T? where T : Decodable {
        if let data = response.data, let parsed = try? JSONDecoder().decode(T.self, from: data) {
            return parsed
        }
        return nil
    }
}
