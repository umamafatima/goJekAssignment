//
//  URLResponseExtension.swift
//  ContactsListDemoApp
//
//  Created by Admin on 22/09/19.
//  Copyright © 2019 Umama. All rights reserved.
//

import Foundation

extension URLResponse {
    var isSuccess: Bool {
        return httpStatusCode >= 200 && httpStatusCode < 300
    }
    
    var httpStatusCode: Int {
        guard let statusCode = (self as? HTTPURLResponse)?.statusCode else {
            return 0
        }
        return statusCode
    }
}
