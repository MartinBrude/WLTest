//
//  RequestService.swift
//  WLTest
//
//  Created by Martin on 18/12/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import UIKit
import Alamofire

class RequestService : RequestServiceProtocol {

    @discardableResult
    func get(path: String, complete: @escaping (DataResponse<Any>) -> (), failure: @escaping (Any?) -> ()) -> DataRequest? {
        return request(method: .get, path: path, complete: complete, failure: failure)
    }

    private func request(method : HTTPMethod, path: String, complete: @escaping (DataResponse<Any>) -> (), failure: @escaping (Any?) -> ()) -> DataRequest? {
        return request(baseUrl: NetworkingConstants.baseUrl, method: method, path: path, complete: complete, failure: failure)
    }

    private func request(baseUrl : String, method : HTTPMethod, path: String, complete: @escaping (DataResponse<Any>) -> (), failure: @escaping (Any?) -> ()) -> DataRequest? {
        if !Connectivity.isReachable() {
            failure(Texts.errorNoInternet)
            return nil
        }
        let url = baseUrl + path
        return Alamofire.request(url, method: method, parameters: nil, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success:
                    complete(response)
                case .failure(_):
                    failure(response)
                }
        }
    }
}
