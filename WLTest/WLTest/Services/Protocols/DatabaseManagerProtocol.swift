//
//  DatabaseManagerProtocol.swift
//  WLTest
//
//  Created by Martin on 25/12/2018.
//  Copyright © 2018 Martin. All rights reserved.
// 

import Foundation
import RealmSwift
import Realm

protocol DatabaseManagerProtocol {
    func get<T>(_ type: T.Type) -> [T]? where T : Object
    func add<S>(_ objects: S) where S : Sequence, S.Element : Object
    func add(_ object: Object)
    func filter<T>(_ type: T.Type, with predicate : String) -> [T]? where T : Object
}
