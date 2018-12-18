//
//  DependencyManager.swift
//  WLTest
//
//  Created by Martin on 18/12/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import UIKit
import Foundation
import Swinject

public class DependencyManager {

    lazy var container: Container = {
        let container = Container()
        container.register(POIServiceProtocol.self) { _ in POIService() }.inObjectScope(.weak)
        container.register(RequestServiceProtocol.self) { _ in RequestService() }.inObjectScope(.weak)
        container.register(DatabaseManagerProtocol.self) { _ in DatabaseManager() }.inObjectScope(.weak)
        return container
    }()

    static let shared = DependencyManager()

    func resolve<T>(interface: T.Type) -> T! {
        return container.resolve(interface)
    }

    private init() {}
}

extension DependencyManager {

    static func resolve<T>(interface: T.Type) -> T! {
        return DependencyManager.shared.resolve(interface: interface)
    }
}
