//
//  AuthUser.swift
//  DoSport
//
//  Created by MAC on 12.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation
import Alamofire

class AuthUser {

    struct RegisterUser: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .post
        var path: String = "api/v1/auth/login"
        var user: UserFullInform

        var parameters: Parameters? {
            return [
                "password": user.password,
                "username": user.login ?? ""
            ]
        }
    }
}
