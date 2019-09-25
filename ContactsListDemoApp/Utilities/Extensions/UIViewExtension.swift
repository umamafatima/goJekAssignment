//
//  UIViewExtension.swift
//  ContactsListDemoApp
//
//  Created by Admin on 25/09/19.
//  Copyright © 2019 Umama. All rights reserved.
//

import Foundation
import UIKit
//import MBProgressHUD
var vSpinner : UIView?
 
extension UIView {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}

extension UIView {
    func showLoader(show: Bool) {
        if show {
            showSpinner(onView: self)
//            MBProgressHUD.showAdded(to: self, animated: true)
        } else {
            removeSpinner()
//            MBProgressHUD.hide(for: self, animated: true)
        }
    }
}
