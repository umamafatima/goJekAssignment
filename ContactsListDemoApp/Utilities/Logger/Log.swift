//
//  Log.swift
//  ContactsListDemoApp
//
//  Created by Admin on 24/09/19.
//  Copyright © 2019 Umama. All rights reserved.
//

import Foundation
import os

struct Log {
    private static let subsystem = Bundle.main.bundleIdentifier!
    private static let appLog = OSLog(subsystem: Log.subsystem, category: "Default")
    
    static func error(_ msg: String, error: Error? = nil, log: OSLog = appLog) {
        os_log("ERROR - %@ %@", log: log, type: .error, msg, error?.localizedDescription ?? "")
    }
    
    static func info(_ msg: String, log: OSLog = appLog) {
        os_log("INFO - %@", log: log, type: .info, msg)
    }
    
    static func debug(_ msg: String, log: OSLog = appLog) {
        os_log("DEBUG - %@", log: log, type: .debug, msg)
    }
}
