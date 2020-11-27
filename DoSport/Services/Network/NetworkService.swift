////
// //  Networkservice.swift
// //  DoSport
// //
// //  Created by MAC on 12.10.2020.
// //  Copyright © 2020 MAC. All rights reserved.
// //
//
//import Foundation
//import Alamofire
//
//protocol NetworkServiceProtocol {
//    func request<T: Decodable>(_ request: URLRequestConvertible,
//                               completion: @escaping (T?) -> Void)
//}
//
//class NetworkService: NetworkServiceProtocol {
//
//    private let errorParcer: ErrorParser
//    private let sessionManager: Session
//
//    init(errorParser: ErrorParser, sessionManager: Session) {
//        self.errorParcer = errorParser
//        self.sessionManager = sessionManager
//    }
//
//    func request<T: Decodable>(_ request: URLRequestConvertible,
//                               completion: @escaping (T?) -> Void) {
//        sessionManager.request(request).validate().responseData { response in
//            do {
//                guard let data = response.data else {
//                    completion(nil)
//                    return
//                }
//                let value = try JSONDecoder().decode(T.self, from: data)
//                completion(value)
//            } catch {
//                completion(nil)
//            }
//        }
//    }
//}
