////
////  AuthService.swift
////  DoSport
////
////  Created by MAC on 12.10.2020.
////  Copyright © 2020 MAC. All rights reserved.
////
//
//import Foundation
//import Alamofire
//
//protocol AuthServiceProtocol {
//    func registerUser(user: UserFullInform, completion: @escaping(String?) -> Void)
//}
//
//class AuthService: AuthServiceProtocol {
//
//    private var baseUrl: URL
//    private let networkService: NetworkServiceProtocol
//
//    init(baseUrl: URL, networkService: NetworkServiceProtocol) {
//        self.baseUrl = baseUrl
//        self.networkService = networkService
//    }
//
//    func registerUser(user: UserFullInform, completion completionHandler: @escaping (String?) -> Void) {
//        let requesModel = AuthUser.RegisterUser(baseUrl: baseUrl, user: user)
//        networkService.request(requesModel) { (response: String?) in
//            completionHandler(response)
//        }
//    }
//}
