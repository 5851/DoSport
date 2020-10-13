//
//  ErrorParser.swift
//  DoSport
//
//  Created by MAC on 12.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation

enum AppError: Error {
    case serverError
    case clientError
    case failData
    case unknownError
}

protocol AbstractErrorParser {

    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}

class ErrorParser: AbstractErrorParser {
    func parse(_ result: Error) -> Error {
        return result
    }
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
}
