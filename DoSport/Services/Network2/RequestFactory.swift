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

    func makeAuthRequestFactory() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        return Auth(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
}
