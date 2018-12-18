//
//  POI.swift
//  WLTest
//
//  Created by Martin on 18/12/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import RealmSwift
import Realm

class POI : Object, Codable {
    @objc dynamic var id, title, geocoordinates : String?

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

class POIs: Codable {
    let list: [POI]

    init(list: [POI]) {
        self.list = list
    }
}
