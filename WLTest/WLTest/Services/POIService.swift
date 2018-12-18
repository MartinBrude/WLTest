//
//  POIService.swift
//  WLTest
//
//  Created by Martin on 18/12/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire

class POIService: POIServiceProtocol {

    private var requestService = DependencyManager.shared.resolve(interface: RequestServiceProtocol.self)
    private var databaseManager = DependencyManager.shared.resolve(interface: DatabaseManagerProtocol.self)
    private var currentRequest : DataRequest?

    func getPois(successful: @escaping ([POI]) -> (), failure: @escaping (String?) -> ()) {
        if let pois = databaseManager?.get(POI.self), pois.count > 0 {
            successful(pois)
        } else {
            _ = requestService?.get(path: NetworkingConstants.points, complete: { [unowned self] (pois) in
                guard let parsedPois = JSONParser.parsePOI(response: pois) else { failure(Texts.errorTitle); return }
                self.databaseManager?.add(parsedPois)
                successful(parsedPois)
                }, failure: { (reason) in
                    failure(reason as? String ?? Texts.errorTitle)
            })
        }
    }

    func getPoiDetail(poiId : String, successful: @escaping (POIDetail) -> (), failure: @escaping (String?) -> ()) {
        if let detail = databaseManager?.get(POIDetail.self)?.filter({$0.id == poiId}).first {
            successful(detail)
        } else {
            currentRequest?.cancel()
            currentRequest = requestService?.get(path: NetworkingConstants.points + "/\(poiId)", complete: { [unowned self] (detail) in
                guard let parsedDetail = JSONParser.parsePOIDetail(response: detail) else { failure(Texts.errorTitle); return }
                self.databaseManager?.add(parsedDetail)
                successful(parsedDetail)
                }, failure: { (reason) in
                    failure(reason as? String ?? Texts.errorTitle)
            })
        }
    }

    func search(text : String) -> [POI] {
        return  databaseManager?.filter(POI.self, with: "title contains '\(text)'") ?? [POI]()
    }
}
