//
//  TransferRecentCollectionCell.swift
//  Nerdbank
//
//  Created by Victor Freitas on 22/04/23.
//

import UIKit

class TransferRecentCollectionCell: UICollectionViewCell {

    // MARK: Outlets
    
    @IBOutlet weak var recentImageView: UIImageView!
    @IBOutlet weak var recentNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        recentImageView.layer.cornerRadius = recentImageView.frame.width / 2
//        recentImageView.clipsToBounds = true
    }
}
