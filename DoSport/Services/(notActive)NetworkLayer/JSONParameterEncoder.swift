////
////  JSONParameterEncoder.swift
////  DoSport
////
////  Created by Sergey on 29.11.2020.
////  Copyright © 2020 MAC. All rights reserved.
////
//
//import Foundation
//
//public struct JSONParameterEncoder: ParameterEncoder {
//    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
//        do {
//            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
//            urlRequest.httpBody = jsonAsData
//            if urlRequest.value(forHTTPHeaderField: "Content-type") == nil {
//                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
//            }
//        } catch {
//            throw NetworkError.encodingFailed
//        }
//    }
//
//
//}
