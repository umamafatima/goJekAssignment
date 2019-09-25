//
//  NSObjectExtension.swift
//  ContactsListDemoApp
//
//  Created by Admin on 25/09/19.
//  Copyright © 2019 Umama. All rights reserved.
//

import Foundation

extension NSObject {
    class var name: String {
        return String(describing: self)
    }
}
