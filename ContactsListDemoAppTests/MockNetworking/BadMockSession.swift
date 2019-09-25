//
//  BadMockSession.swift
//  ContactsListDemoAppTests
//
//  Created by Admin on 22/09/19.
//  Copyright © 2019 Umama. All rights reserved.
//


import Foundation
@testable import ContactsListDemoApp

//BadMockSession will always return error or nil response
class BadMockSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        
        if let mockRequest =  MockRequest.identifyRequest(request: request) {
            mockRequest.badCompletionHandler(request: request, completion: completionHandler)
        }
        
        return MockDataTask()
    }
}
