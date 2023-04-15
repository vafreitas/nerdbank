//
//  TransactionTableViewCell.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 25/09/22.
//

import UIKit
import SkeletonView

class TransactionTableViewCell: UITableViewCell {

    // MARK: Properties
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var transactionTypeLabel: UILabel!
    @IBOutlet weak var recipientNameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    let redColor = UIColor(hexString: "#D52600")
    let greenColor = UIColor(hexString: "#149E64")
    
    // MARK: Setup Method
    
    func setup(_ model: Transaction) {
        transactionTypeLabel.text = model.transactionType == "TRANSFER" ? "Transferência" : "Pagamento de Conta"
        recipientNameLabel.text = model.recipientName
        valueLabel.text = model.movementType == "OUT" ? "- \(model.formattedValue)" : model.formattedValue
        let color: UIColor = model.movementType == "OUT" ? redColor : greenColor
        valueLabel.textColor = color
        dateLabel.text = model.formattedDate
    }
  
    func showSkeleton() {
        transactionTypeLabel.showAnimatedGradientSkeleton()
        recipientNameLabel.showAnimatedGradientSkeleton()
        valueLabel.showAnimatedGradientSkeleton()
        dateLabel.showAnimatedGradientSkeleton()
    }
    
    func hideSkeleton() {
        transactionTypeLabel.hideSkeleton()
        recipientNameLabel.hideSkeleton()
        valueLabel.hideSkeleton()
        dateLabel.hideSkeleton()
    }
}
