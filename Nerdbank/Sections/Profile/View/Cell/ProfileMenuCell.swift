//
//  ProfileMenuCell.swift
//  Nerdbank
//
//  Created by Victor Freitas on 19/04/23.
//

import UIKit

class ProfileMenuCell: UITableViewCell {

    // MARK: Outlets
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: Setup
    
    func setup(_ model: ProfileMenuOption) {
        iconImageView.image = UIImage(named: model.icon)
        titleLabel.text = model.title
    }
    
}
