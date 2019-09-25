//
//  MockContact.swift
//  ContactsListDemoAppTests
//
//  Created by Admin on 22/09/19.
//  Copyright © 2019 Umama. All rights reserved.
//


import Foundation
import CoreData

@testable import ContactsListDemoApp

struct MockContact {
    static func getEmpty() -> Contact {
        let managedObjectContext = CoreDataManager.shared.managedObjectContext
        guard let entity = NSEntityDescription.entity(forEntityName: Contact.name, in: managedObjectContext) else {
            fatalError("Unable to create Contact entity.")
        }
        
        let contact = Contact(entity: entity, insertInto: nil)
        return contact
    }
    
    static func getPartial() -> Contact {
        let contact = getEmpty()
        contact.id = 1
        contact.firstName = "Anonymous"
        contact.lastName = "Anonymous"
        contact.profilePic = "image.png"
        contact.favorite = false
        return contact
    }
    
    static func getComplete() -> Contact {
        let contact = getPartial()
        contact.phoneNumber = "+910987654321"
        contact.email = "vc@gmail.com"
        return contact
    }
}
