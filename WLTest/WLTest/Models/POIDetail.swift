//
//  POIDetail.swift
//  WLTest
//
//  Created by Martin on 20/12/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import RealmSwift
import Realm

class POIDetail : Object, Codable {

    @objc dynamic var id, title, address, transport, email, geocoordinates, phone, desc : String?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case address = "address"
        case geocoordinates = "geocoordinates"
        case transport = "transport"
        case phone = "phone"
        case desc = "description"
    }

    //MARK : Realm required

    required init() {
        super.init()
    }

    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }

    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}
