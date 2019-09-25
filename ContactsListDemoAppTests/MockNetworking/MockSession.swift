//
//  MockSession.swift
//  ContactsListDemoAppTests
//
//  Created by Admin on 22/09/19.
//  Copyright © 2019 Umama. All rights reserved.
//


import Foundation
@testable import ContactsListDemoApp

//MokeSession or Good MockSession always return success response
class MockSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        
        if let mockRequest =  MockRequest.identifyRequest(request: request) {
            mockRequest.completionHandler(request: request, completion: completionHandler)
        }
        
        return MockDataTask()
    }
}
