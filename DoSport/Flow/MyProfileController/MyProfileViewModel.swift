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
    var username: String {get}
    func getUserInfo (token: String, completion: @escaping(UserInfoResult) -> Void)
}

class MyProfileViewModelImpl: MyProfileViewModel {
    func getUserInfo(token: String, completion: @escaping (UserInfoResult) -> Void) {
        let request = networkManager.makeUserInfoRequest()
        print("request printin \(request)")
        request.getInfo(token: token) { (response) in
            switch response.result {
            case .success(let success):
                completion(success)
                print("success username \(success.username), success ID \(success.id) ")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    let networkManager = RequestFactory()
    private let model: UserInfoResult
    init(model: UserInfoResult) {
        self.model = model
    }
    var firstname: String {
        return model.firstName
    }
    var lastname: String {
        return model.lastName
    }
    var username: String {
        return model.username
    }
}
