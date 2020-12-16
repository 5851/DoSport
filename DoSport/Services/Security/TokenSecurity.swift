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
        
        UserDefaults.standard.setValue("Bearer_"+token+"", forKey: "token")
    }
    func loadToken() -> String {
        if let token = UserDefaults.standard.object(forKey: "token") as? String {
        return token
        } else {
            return ""
        }
//        let token = "23njrnwioufhq284u32"
//                let tokenData = token.data(using: String.Encoding.utf8)
//                if let base64EncodedCredential = tokenData?.base64EncodedString() {
//                    let authString = "Bearer_\(base64EncodedCredential)"
//                    config.httpAdditionalHeaders = ["Authorization": authString]
//                }
    }
}
