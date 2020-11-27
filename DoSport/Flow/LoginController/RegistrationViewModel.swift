//
//  RegisterationViewModel.swift
//  DoSport
//
//  Created by Sergey on 04.11.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation

protocol RegistrationViewModel {
    var firstname: String {get}
    var lastname: String {get}
    var password: String {get}
    var passwordConfirm: String {get}
    var username: String {get}
    func placeRregisterRequest (firstname: String, lastname: String,
                                password: String, passwordConfirm: String,
                                username: String, completion: @escaping (RegisterResult) -> Void)
    func login (username: String, password: String)
}

class RegistrationViewModelImpl: RegistrationViewModel {
    let networkManager = RequestFactory()
    private let model: User
    init(model: User) {
        self.model = model
    }
    var firstname: String {
        return model.firstname
    }
    var lastname: String {
        return model.lastname
    }
    var password: String {
        return model.password
    }
    var passwordConfirm: String {
        return model.passwordConfirm
    }
    var username: String {
        return model.username
    }
    func placeRregisterRequest (firstname: String, lastname: String,
                                password: String, passwordConfirm: String,
                                username: String, completion: @escaping (RegisterResult) -> Void)  {
        let request = networkManager.makeRegisterRequest()
        request.register(firstname: firstname, lastname: lastname, password: password, passwordConfirm: passwordConfirm, username: username, completionHandler: { (response) in
            switch response.result {
            case .success(let success):
                completion(success)
                print("success username \(success.username), success ID \(success.id) ")
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    func login(username: String, password: String) {
        let request = networkManager.makeAuthRequest()
        request.login(userName: username, password: password) { (response) in
            switch response.result {
            case .success(let success):
                let temp = Token()
                temp.saveToken(token: success.token)
                print(temp.loadToken())
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
