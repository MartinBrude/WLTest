//
//  Connectivity.swift
//  WLTest
//
//  Created by Martin on 18/12/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class func isReachable() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
