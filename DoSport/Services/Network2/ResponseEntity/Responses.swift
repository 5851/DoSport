//
//  Responses.swift
//  DoSport
//
//  Created by Sergey on 13.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation

//Структуры для парсинга ответов с сервера

// MARK: - LoginResult
struct LoginResult: Codable {
    let roles: [Role]
    let username, token: String
    enum CodingKeys: String, CodingKey {
        case username
        case token
        case roles
    }
}

// MARK: - Role
struct Role: Codable {
    let authority: String
}

struct Test: Codable {
    let code: Int
    let message: String
}
