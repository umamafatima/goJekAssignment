//
//  ServerError.swift
//  ContactsListDemoApp
//
//  Created by Admin on 24/09/19.
//  Copyright © 2019 Umama. All rights reserved.
//

import Foundation

struct ServerError: Decodable {
    let status: String?
    let error: String?
}
