//
//  RequestRouter.swift
//  DoSport
//
//  Created by MAC on 12.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation
import Alamofire

enum RequestRouterEncoding {
    case url, json
}

protocol RequestRouter: URLRequestConvertible {
    var baseUrl: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var fullUrl: URL { get }
    var encoding: RequestRouterEncoding { get }
}

extension RequestRouter {
    var fullUrl: URL {
        return baseUrl.appendingPathComponent(path)
    }

    var encoding: RequestRouterEncoding {
        return .json
    }
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: fullUrl)
        urlRequest.httpMethod = method.rawValue

        switch self.encoding {
        case .url:
            return try URLEncoding.default.encode(urlRequest, with: parameters)
        case .json:
            return try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
    }
}
