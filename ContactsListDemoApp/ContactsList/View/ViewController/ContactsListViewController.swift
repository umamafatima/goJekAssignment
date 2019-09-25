//
//  ContactsListViewController.swift
//  ContactsListDemoApp
//
//  Created by Admin on 22/09/19.
//  Copyright © 2019 Umama. All rights reserved.
//

import UIKit
import CoreData

class ContactListViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var contactTableView: UITableView!
    
    // MARK: - Private Properties
    private let viewModel = ContactListViewModel()
    var fetchedResultController: NSFetchedResultsController<Contact>?
    
    // MARK: - Class Functions
    class func get() -> ContactListViewController {
        let contactViewController = ContactListViewController(nibName: ContactListViewController.name, bundle: nil)
        return contactViewController
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        
        contactTableView.delegate = self
        contactTableView.dataSource = self
        contactTableView.tableFooterView = UIView(frame: CGRect.zero)
        contactTableView.register(ContactTableViewCell.nib, forCellReuseIdentifier: ContactTableViewCell.identifier)
        contactTableView.accessibilityIdentifier = "contactListTableView"
        
        setupNavigationBarButtonItems()
        setupFetchedResultController()
        setupBindingAndGetContacts()
    }
    
    // MARK: - Helper Functions
    private func setupNavigationBarButtonItems() {
        let groupsBarButtonItem = UIBarButtonItem(title: viewModel.groupBarButtonTitle,
                                                  style: .plain,
                                                  target: self,
                                                  action: nil)
        navigationItem.leftBarButtonItem = groupsBarButtonItem
        
        let addContactBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                      target: self,
                                                      action: #selector(addContactBarButtonItemAction))
        navigationItem.rightBarButtonItem = addContactBarButtonItem
    }
    
    private func setupFetchedResultController() {
        let contactsFetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Contact.firstName),
                                              ascending: true,
                                              selector: #selector(NSString.caseInsensitiveCompare(_:)))
        contactsFetchRequest.sortDescriptors = [sortDescriptor]
        let managedObjectContext = CoreDataManager.shared.managedObjectContext
        fetchedResultController = .init(fetchRequest: contactsFetchRequest,
                                        managedObjectContext: managedObjectContext,
                                        sectionNameKeyPath: #keyPath(Contact.sectionTitle),
                                        cacheName: nil)
        fetchedResultController?.delegate = self
    }
    
    private func performFetchRequest() {
        do {
            try fetchedResultController?.performFetch()
            contactTableView.reloadData()
        } catch {
            Log.error("Unable to perform fetch operation from DB.", error: error)
        }
    }
    
    private func setupBindingAndGetContacts() {
        //Binding
        viewModel.isBusy.bind { [unowned self] isBusy in
            self.view.showLoader(show: isBusy)
        }
        
        viewModel.contacts.bind { [unowned self] (contacts) in
            if contacts != nil {
                self.performFetchRequest()
            }
        }
        
        viewModel.error.bind { [unowned self] (error) in
            if let error = error {
                self.performFetchRequest()
                UIAlertController.show(error.localizedDescription, from: self)
            }
        }
        
        //Get Contacts
        viewModel.getContacts()
    }
    
    @objc private func addContactBarButtonItemAction() {
        AddContactViewController.present(contact: nil)
    }
}

// MARK: - NSFetchResultController Delegate
extension ContactListViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        contactTableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            contactTableView.insertRows(at: [newIndexPath!], with: .none)
        case .delete:
            contactTableView.deleteRows(at: [indexPath!], with: .none)
        case .update:
            contactTableView.reloadRows(at: [indexPath!], with: .none)
        case .move:
            contactTableView.moveRow(at: indexPath!, to: newIndexPath!)
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            contactTableView.insertSections(IndexSet(integer: sectionIndex), with: .none)
        case .delete:
            contactTableView.deleteSections(IndexSet(integer: sectionIndex), with: .none)
        case .update:
            contactTableView.reloadSections(IndexSet(integer: sectionIndex), with: .none)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        contactTableView.endUpdates()
    }
    
}

// MARK: - UITableView Data Source
extension ContactListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultController?.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController?.sections?[section].objects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier,
                                                       for: indexPath) as? ContactTableViewCell else {
            fatalError("Unable to dequeue ContactTableViewCell.")
        }
        cell.config(contact: fetchedResultController!.object(at: indexPath))
        cell.accessibilityIdentifier = String(format: "contactTableViewCell_%ld_%ld", indexPath.section, indexPath.row)
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return fetchedResultController?.sectionIndexTitles
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return fetchedResultController?.sections?[section].indexTitle
    }
}

extension ContactListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = fetchedResultController!.object(at: indexPath)
        let contactDetailsViewController = ContactDetailsViewController.get(contact: contact)
        navigationController?.pushViewController(contactDetailsViewController, animated: true)
    }
}

