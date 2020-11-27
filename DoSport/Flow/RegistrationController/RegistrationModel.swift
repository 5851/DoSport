//
//  RegistrationModel.swift
//  DoSport
//
//  Created by Sergey on 04.11.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation
import UIKit

protocol RegisterModel {
    var firstname: String {get}
    var lastname: String {get}
    var password: String {get}
    var passwordConfirm: String {get}
    var username: String {get}
}

protocol RegisterBtnValidate {
   func isCodeValid (_ symbol: String) -> Bool
   var symbolLenght: Int {get}
}

<<<<<<< HEAD:DoSport/Flow/RegistrationController/RegistrationModel.swift
struct User: RegisterModel {
=======
struct User: RegisterModel{
>>>>>>> udalov_features:DoSport/Flow/LoginController/RegistrationModel.swift
    let firstname: String
    let lastname: String
    let password: String
    let passwordConfirm: String
    let username: String
}

extension User: RegisterBtnValidate {
    func isCodeValid(_ symbol: String) -> Bool {
        return symbol.count >= symbolLenght
    }
<<<<<<< HEAD:DoSport/Flow/RegistrationController/RegistrationModel.swift

=======
>>>>>>> udalov_features:DoSport/Flow/LoginController/RegistrationModel.swift
    var symbolLenght: Int {
        return 4
    }
}
