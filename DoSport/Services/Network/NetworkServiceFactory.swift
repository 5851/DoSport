////
// //  NetworkServiceFactory.swift
// //  DoSport
// //
// //  Created by MAC on 12.10.2020.
// //  Copyright © 2020 MAC. All rights reserved.
////
//
//import Foundation
//import Alamofire
//
//class NetworkServiceFactory {
//
//    static let shared: NetworkServiceFactory = NetworkServiceFactory()
//
//    private(set) lazy var commonSessionManager: Session = {
//        let configuration = URLSessionConfiguration.default
//        configuration.httpShouldSetCookies = false
//        let manager = Session(configuration: configuration)
//        return manager
//    }()
//
//    private let configuration = Configuration()
//    private let errorParser = ErrorParser()
//
//    private(set) lazy var networkService: NetworkServiceProtocol = NetworkService(
//        errorParser: errorParser,
//        sessionManager: commonSessionManager)
//
//    private init() {}
//
//    func makeAuthRequestFactory() -> AuthService {
//        return AuthService(baseUrl: configuration.baseUrl, networkService: networkService)
//    }
//}
