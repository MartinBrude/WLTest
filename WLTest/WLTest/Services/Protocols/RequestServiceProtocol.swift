//
//  RequestServiceProtocol.swift
//  WLTest
//
//  Created by Martin on 25/12/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestServiceProtocol {
    func get(path: String, complete: @escaping (DataResponse<Any>) -> (), failure: @escaping (Any?) -> ()) -> DataRequest?
}
