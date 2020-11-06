//
//  RequestFactory.swift
//  DoSport
//
//  Created by Sergey on 13.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation
import Alamofire

class RequestFactory {

    let sessionQueue = DispatchQueue.global(qos: .utility)

    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }

    lazy var commonSessionManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        let manager = Session(configuration: configuration)
        return manager
    }()
//MARK: - тут выносишь по данному принципу все реквесты, которые потом легко доступны через класс
    func makeAuthRequest() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        return AuthRequest(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    func makeRegisterRequest() -> RegisterRequestFactory {
        let errorParser = makeErrorParser()
        return RegisterRequest(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
}
