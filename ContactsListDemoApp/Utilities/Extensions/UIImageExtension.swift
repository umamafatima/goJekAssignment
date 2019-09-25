//
//  UIImageExtension.swift
//  ContactsListDemoApp
//
//  Created by Admin on 25/09/19.
//  Copyright © 2019 Umama. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    struct Contact {
        static let placeHolder = #imageLiteral(resourceName: "placeholder_photo")
        static let showFavorite = #imageLiteral(resourceName: "home_favourite")
    }
    
    struct Action {
        static let call = #imageLiteral(resourceName: "call_button")
        static let mail = #imageLiteral(resourceName: "email_button")
        static let message = #imageLiteral(resourceName: "email_button")
        static let favorite = #imageLiteral(resourceName: "favourite_button")
        static let favoriteSelected = #imageLiteral(resourceName: "favourite_button_selected")
        static let takePhoto = #imageLiteral(resourceName: "camera_button")
    }
}
