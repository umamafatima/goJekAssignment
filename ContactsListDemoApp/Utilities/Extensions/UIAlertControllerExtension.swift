//
//  UIAlertViewController.swift
//  ContactsListDemoApp
//
//  Created by Admin on 25/09/19.
//  Copyright © 2019 Umama. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    static func show(_ message: String, from viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .cancel, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
