//
//  MyProfileModel.swift
//  DoSport
//
//  Created by Sergey on 23.11.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation

struct MyProfileModel: Codable {
    let birthdayDate, firstName, gender: String
    let hideBirthdayDate: Bool
    let id: Int
    let info, lastName, photoLink, username: String
}
