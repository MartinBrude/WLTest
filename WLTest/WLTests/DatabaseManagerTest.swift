//
//  DatabaseManagerTest.swift
//  WLTests
//
//  Created by Martin on 25/12/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import XCTest
import Realm
import RealmSwift

@testable import WLTest


class FakeDatabaseManager : DatabaseManager {
    override init() {
        super.init()
        database = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "realm-inMemory"))
    }
}

class DatabaseManagerTest: XCTestCase {

    private var databaseManager = FakeDatabaseManager()

    let fakeJson = "{\"list\": [{\"id\": \"1\",\"title\": \"Casa Batlló\", \"geocoordinates\": \"41.391926,2.165208\"},{\"id\": \"2\",\"title\": \"Fundacio Antoni Tpies\",\"geocoordinates\": \"41.39154,2.163835\"},{\"id\": \"3\",\"title\": \"Hospital de Sant Pau\",\"geocoordinates\": \"41.674202,2.314628\"}]}"


    let fakeJsonPOIDetail = "{\"id\":\"1\",\"title\":\"Casa Batllo\",\"address\":\"Paseo de Gracia, 43, 08007 Barcelona\",\"transport\":\"Underground:Passeig de Gracia -L3\",\"email\":\"www.casabatllo.es\",\"geocoordinates\":\"41.391926,2.165208\",\"description\":\"Casa Batll is a key feature in the architecture of modernist Barcelona. It was built by Antoni Gaudi between 1904 and 1906 having been commissioned by the textile industrialist Josep Batllo. Nowadays, the spectacular facade is an iconic landmark in the city. The \\\"Manzana de la Discordia\\\", or Block of Discord, is a series of buildings in Passeig de Gracia. It is home to a collection of works by the most renowned architects, amongst which is Casa Batllo. The house, now a museum, is open to the public, both for cultural visits and for celebrating events in its splendid modernist function rooms.\",\"phone\":\"info@casabatllo.cat\"}"

    func testAddAndGetObject() {
        if let data: Data = fakeJsonPOIDetail.data(using: String.Encoding.utf8) {
            let result = try! JSONDecoder().decode(POIDetail.self, from: data)
            databaseManager.add(result)
            let persisted = databaseManager.get(POIDetail.self)
            XCTAssert(persisted?.count == 1)
        }
    }

    func testAddAndGetObjectList() {
        if let data: Data = fakeJson.data(using: String.Encoding.utf8) {
            let result = try! JSONDecoder().decode(POIs.self, from: data)
            databaseManager.add(result.list)
            let persisted = databaseManager.get(POI.self)
            XCTAssert(persisted?.count == 3)
        }
    }
}
