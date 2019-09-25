//
//  ContactListErrorTests.swift
//  ContactsListDemoAppTests
//
//  Created by Admin on 22/09/19.
//  Copyright © 2019 Umama. All rights reserved.
//


import XCTest
@testable import ContactsListDemoApp

class ContactListErrorTests: XCTestCase {

    var contactListViewModel: ContactListViewModel!
    
    override func setUp() {
        let session = BadMockSession()
        let client = HTTPClient(session: session)
        contactListViewModel = ContactListViewModel(client: client)
    }
    
    override func tearDown() {
        
    }
    
    func testContactsAPIFailedResponse() {
        let expectation = self.expectation(description: "No error return by API.")
        
        contactListViewModel.error.bind { (error) in
            if error != nil {
                expectation.fulfill()
            }
        }
        
        contactListViewModel.getContacts()
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
}
