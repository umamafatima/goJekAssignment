//
//  RequestProtocol.swift
//  ContactsListDemoApp
//
//  Created by Admin on 22/09/19.
//  Copyright © 2019 Umama. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

protocol RequestProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var httpBody: Data? { get }
    var headers: HTTPHeaders? { get }
}
