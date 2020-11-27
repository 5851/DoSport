//
//  TokenSecurity.swift
//  DoSport
//
//  Created by Sergey on 15.11.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation
//MARK:- Временное решение
class Token {
    func saveToken(token: String) {
        UserDefaults.standard.setValue(token, forKey: "token")
    }
    func loadToken() -> String {
        if let token = UserDefaults.standard.object(forKey: "token") as? String {
        return token
        } else {
            return ""
        }
    }
}
