//
//  ContactEditTableViewCell.swift
//  ContactsListDemoApp
//
//  Created by Admin on 25/09/19.
//  Copyright © 2019 Umama. All rights reserved.
//

import UIKit

protocol ContactEditTableViewCellDelegate: class {
    func textChanged(contactMetaData: ContactMetadata, text: String)
}

class ContactEditTableViewCell: UITableViewCell {

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var infoTextField: UITextField!
    
    var contactMetadata: ContactMetadata!
    weak var delegate: ContactEditTableViewCellDelegate?
    
    static let identifier = ContactEditTableViewCell.name
    static let nib = UINib(nibName: ContactEditTableViewCell.name, bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(metaData: ContactMetadata) {
        contactMetadata = metaData
        descLabel.text = metaData.desc
        infoTextField.text = metaData.info
        infoTextField.keyboardType = metaData.keyboardType
    }
}
