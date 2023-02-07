//
//  TransactionTableViewCell.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 25/09/22.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    // MARK: Properties
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var transactionTypeLabel: UILabel!
    @IBOutlet weak var recipientNameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: Setup Method
    
    func setup(_ model: Transaction) {
        transactionTypeLabel.text = model.transactionType == "TRANSFER" ? "Transferência" : "Pagamento de Conta"
        recipientNameLabel.text = model.recipientName
        valueLabel.text = model.movementType == "OUT" ? "- \(model.formattedValue)" : model.formattedValue
        let color: UIColor = model.movementType == "OUT" ? .red : .green
        valueLabel.textColor = color
        dateLabel.text = model.formattedDate
    }
  
}
