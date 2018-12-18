//
//  POIServiceTest.swift
//  WLTests
//
//  Created by Martin on 25/12/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import XCTest
import Alamofire

@testable import WLTest

class FakeSuccessPOIService : POIServiceProtocol {
    var didCallGetPois = false
    var didCallGetPoiDetail = false
    let fakeJson = "{\"list\": [{\"id\": \"1\",\"title\": \"Casa Batlló\", \"geocoordinates\": \"41.391926,2.165208\"},{\"id\": \"2\",\"title\": \"Fundacio Antoni Tpies\",\"geocoordinates\": \"41.39154,2.163835\"},{\"id\": \"3\",\"title\": \"Hospital de Sant Pau\",\"geocoordinates\": \"41.674202,2.314628\"}]}"

    let fakeJsonPOIDetail = "{\"id\":\"1\",\"title\":\"Casa Batllo\",\"address\":\"Paseo de Gracia, 43, 08007 Barcelona\",\"transport\":\"Underground:Passeig de Gracia -L3\",\"email\":\"www.casabatllo.es\",\"geocoordinates\":\"41.391926,2.165208\",\"description\":\"Casa Batll is a key feature in the architecture of modernist Barcelona. It was built by Antoni Gaudi between 1904 and 1906 having been commissioned by the textile industrialist Josep Batllo. Nowadays, the spectacular facade is an iconic landmark in the city. The \\\"Manzana de la Discordia\\\", or Block of Discord, is a series of buildings in Passeig de Gracia. It is home to a collection of works by the most renowned architects, amongst which is Casa Batllo. The house, now a museum, is open to the public, both for cultural visits and for celebrating events in its splendid modernist function rooms.\",\"phone\":\"info@casabatllo.cat\"}"

    func getPois(successful: @escaping ([POI]) -> (), failure: @escaping (String?) -> ()) {
        didCallGetPois = true
        if let data: Data = fakeJson.data(using: String.Encoding.utf8) {
            let result = try! JSONDecoder().decode(POIs.self, from: data)
            successful(result.list)
        }
    }

    func getPoiDetail(poiId : String, successful: @escaping (POIDetail) -> (), failure: @escaping (String?) -> ()) {
        didCallGetPoiDetail = true
        if let data: Data = fakeJsonPOIDetail.data(using: String.Encoding.utf8) {
            let result = try! JSONDecoder().decode(POIDetail.self, from: data)
            successful(result)
        }
    }

    func search(text : String) -> [POI] {
        return [POI]()
    }

}


class FakeFailurePOIService : POIServiceProtocol {
    var didCallGetPois = false
    var didCallGetPoiDetail = false

    func getPois(successful: @escaping ([POI]) -> (), failure: @escaping (String?) -> ()) {
        didCallGetPois = true
        failure(Texts.errorFetchingPois)
    }

    func getPoiDetail(poiId : String, successful: @escaping (POIDetail) -> (), failure: @escaping (String?) -> ()) {
        didCallGetPoiDetail = true
        failure(Texts.errorFetchingPoiDetail)
    }

    func search(text : String) -> [POI] {
        return [POI]()
    }
}


class POIServiceTest: XCTestCase {

    var successService : FakeSuccessPOIService?
    var failureService : FakeFailurePOIService?

    override func setUp() {
        successService = FakeSuccessPOIService()
        failureService = FakeFailurePOIService()
    }

    override func tearDown() {
        successService = nil
    }

    func testGetPois() {
        XCTAssertFalse(successService?.didCallGetPois ?? false)
        successService?.getPois(successful: { (result) in
            XCTAssertTrue(self.successService?.didCallGetPois ?? false)
            XCTAssert(result.count == 3)
        }, failure: { (failure) in
        })
    }

    func testGetPoiDetail() {
        XCTAssertFalse(successService?.didCallGetPoiDetail ?? false)
        successService?.getPoiDetail(poiId: "1", successful: { (detail) in
            XCTAssertNotNil(detail)
            XCTAssertTrue(self.successService?.didCallGetPoiDetail ?? false)
        }, failure: { (failure) in
        })
    }


    func testGetPoisFails() {
        XCTAssertFalse(successService?.didCallGetPois ?? false)
        failureService?.getPois(successful: { (result) in
        }, failure: { (failure) in
            XCTAssertNotNil(failure)
            XCTAssertTrue(self.failureService?.didCallGetPois ?? false)
        })
    }

    func testGetPoiDetailFails() {
        failureService?.getPoiDetail(poiId: "1", successful: { (detail) in
        }, failure: { (failure) in
            XCTAssertNotNil(failure)
        })
    }
}
