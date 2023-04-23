//
//  TransferOptionCell.swift
//  Nerdbank
//
//  Created by Victor Freitas on 22/04/23.
//

import UIKit

class TransferFavoriteOptionCell: UITableViewCell {

    // MARK: Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: Setup
    
    func setup(_ model: TransferOption) {
        nameLabel.text = model.name
    }
}
