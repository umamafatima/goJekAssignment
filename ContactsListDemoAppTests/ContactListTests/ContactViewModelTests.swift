//
//  ContactsListDemoAppTests.swift
//  ContactsListDemoAppTests
//
//  Created by Admin on 22/09/19.
//  Copyright © 2019 Umama. All rights reserved.
//

import XCTest
@testable import ContactsListDemoApp

class ContactViewModelTests: XCTestCase {
    
    var contact: Contact!
    var contactViewModel: ContactViewModel!
    
    override func setUp() {
        contact = MockContact.getPartial()
        contactViewModel = ContactViewModel(contact: contact)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testContactFullName() {
        XCTAssert(contactViewModel.name == "Anonymous Anonymous", "Complete name mismatch.")
    }
    
    func testFavoriteContact() {
        XCTAssert(contactViewModel.isFavorite == false, "Contact was favorite but view model return contact is not favorite")
    }
    
    func testProfilePicURL() {
        let testURL = URL(string: "image.png")
        XCTAssert(contactViewModel.imageURL == testURL, "Contact profile URL mismatch.")
    }
}
