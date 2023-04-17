//
//  HomeCollectionCell.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 17/04/23.
//

import UIKit

class HomeCollectionCell: UICollectionViewCell {

    // MARK: Outlets
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: Setup
    
    func setup(_ model: HomeMenuModel) {
        iconImageView.image = model.image
        titleLabel.text = model.title
    }
}
