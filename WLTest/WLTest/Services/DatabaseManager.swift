//
//  DatabaseManager.swift
//  WLTest
//
//  Created by Martin on 22/12/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import RealmSwift
import Realm

class DatabaseManager : DatabaseManagerProtocol {

    var database : Realm?
    static let sharedInstance = DatabaseManager()
    
    init() {
        database = try? Realm()
    }

    func add<S>(_ objects: S) where S : Sequence, S.Element : Object {
        try? database?.write {
            database?.add(objects, update: false)
        }
    }

    func add(_ object: Object) {
        try? database?.write {
            database?.add(object, update: false)
        }
    }

    func get<T>(_ type: T.Type) -> [T]? where T : Object {
        guard let db = database else { return nil }
        return Array(db.objects(T.self))
    }

    func filter<T>(_ type: T.Type, with predicate : String) -> [T]? where T : Object {
        guard let db = database else { return nil }
        return Array(db.objects(type.self).filter(predicate))
    }
}
