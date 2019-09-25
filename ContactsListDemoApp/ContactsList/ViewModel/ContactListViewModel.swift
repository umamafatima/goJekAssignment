//
//  ContactListViewModel.swift
//  ContactsListDemoApp
//
//  Created by Admin on 22/09/19.
//  Copyright © 2019 Umama. All rights reserved.
//

import Foundation

class ContactViewModel {
    private let contact: Contact!
    
    let name: String
    let imageURL: URL?
    let isFavorite: Bool
    
    init(contact: Contact) {
        self.contact = contact
        
        name = contact.fullName
        imageURL = URL(string: contact.profilePic ?? "")
        isFavorite = contact.favorite
    }
}


class ContactListViewModel {
    
    private var httpClient: HTTPClient!
    
    let title = NSLocalizedString("Contact", comment: "")
    let groupBarButtonTitle = NSLocalizedString("Groups", comment: "")
    
    var isBusy: Bindable<Bool> = Bindable(false)
    var contacts: Bindable<[Contact]?> = Bindable(nil)
    var error: Bindable<GJError?> = Bindable(nil)
    
    init(client: HTTPClient? = nil) {
        self.httpClient = client ?? HTTPClient.shared
    }
    
    func getContacts() {
        isBusy.value = true
        httpClient.dataTask(ContactAPI.getContacts) { [weak self] (result) in
            guard let self = self else {
                return
            }
            
            self.isBusy.value = false
            switch result {
            case .success(let data):
                guard let data = data else {
                    return
                }
                
                do {
                    let contacts = try JSONDecoder().decode([Contact].self, from: data)
                    self.contacts.value = contacts
                    Log.info("Contact sync successfully.")
                } catch {
                    Log.error("Unable to decode Contact List", error: error)
                }
            case .failure(let error):
                self.error.value = GJError(error.localizedDescription)
                Log.error("Error in fetching Contacts", error: error)
            }
        }
    }
}
