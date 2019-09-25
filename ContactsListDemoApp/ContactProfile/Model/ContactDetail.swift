//
//  ContactDetail.swift
//  ContactsListDemoApp
//
//  Created by Admin on 22/09/19.
//  Copyright © 2019 Umama. All rights reserved.
//

import Foundation
import UIKit

enum ContactMetadataType {
    case firstName, lastName, email, mobile
}

class ContactMetadata {
    var desc: String!
    var info: String!
    var type: ContactMetadataType
    var keyboardType: UIKeyboardType
    
    init(desc: String, info: String?, type: ContactMetadataType, keyboardType: UIKeyboardType = .default) {
        self.desc = desc
        self.info = info
        self.type = type
        self.keyboardType = keyboardType
    }
}
