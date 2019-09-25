//
//  GJError.swift
//  ContactsListDemoApp
//
//  Created by Admin on 22/09/19.
//  Copyright © 2019 Umama. All rights reserved.
//

import Foundation

typealias GJErrorHandler = (GJError?) -> Void

struct GJError: Error {
    var localizedDescription: String
    init(_ localizedDescription: String) {
        self.localizedDescription = localizedDescription
    }
}
