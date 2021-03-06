//
//  GetUserInfo.swift
//  DoSport
//
//  Created by Sergey on 16.11.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation
import Alamofire

protocol UserInfoRequestFactory {
    func getInfo(token: String, completionHandler: @escaping (AFDataResponse<UserInfoResult>) -> Void)
}

class GetInfoRequest: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue?
    let baseUrl = URL(string: "https://dosport-ru.herokuapp.com/api/v1/")!
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue? = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension GetInfoRequest: UserInfoRequestFactory {
    func getInfo(token: String, completionHandler: @escaping (AFDataResponse<UserInfoResult>) -> Void) {
        let header = HTTPHeader(name: "Authorization", value: token)
        let headers = HTTPHeaders([header])
        let requestModel = GetInfo(headers: headers, baseUrl: baseUrl)
        self.request(request: requestModel, completionHandler: completionHandler)
        print("requestmodel printng \(requestModel)")
    }
}

extension GetInfoRequest {
    struct GetInfo: RequestRouter {
        var headers: HTTPHeaders
        var parameters: Parameters?
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "profile"
    }
}
