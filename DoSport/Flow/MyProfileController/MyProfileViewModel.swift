//
//  MyProfileViewModel.swift
//  DoSport
//
//  Created by Sergey on 15.11.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation

protocol MyProfileViewModel {
    var firstname: String {get}
    var lastname: String {get}
    var password: String {get}
    var passwordConfirm: String {get}
    var username: String {get}
//    func getUserInfo (comletion: @escaping())
}

class MyProfileViewModelImpl: MyProfileViewModel {
    var firstname: String = ""
    var lastname: String = ""
    var password: String = ""
    var passwordConfirm: String = ""
    var username: String = ""
}
