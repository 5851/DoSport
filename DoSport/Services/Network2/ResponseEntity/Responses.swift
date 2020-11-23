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
    let token: String
    enum CodingKeys: String, CodingKey {
        case token
    }
}

//MARK: - RegisterResult
struct RegisterResult: Codable {
    let id: Int
    let username: String
}
//MARK: - UserInfoResult
struct UserInfoResult: Codable {
    let birthdayDate, firstName, gender: String
    let hideBirthdayDate: Bool
    let id: Int
    let info, lastName, photoLink, username: String
}

