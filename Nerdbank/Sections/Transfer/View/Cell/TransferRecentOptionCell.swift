//
//  TransferRecentOptionCell.swift
//  Nerdbank
//
//  Created by Victor Freitas on 22/04/23.
//

import UIKit

class TransferRecentOptionCell: UITableViewCell {

    // MARK: Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Properties
    
    var recents: [TransferOption]?
    
    func setup(_ recents: [TransferOption]) {
        self.recents = recents
        collectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(.init(nibName: "TransferRecentCollectionCell", bundle: .main), forCellWithReuseIdentifier: "TransferRecentCollectionCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension TransferRecentOptionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recents?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TransferRecentCollectionCell", for: indexPath) as? TransferRecentCollectionCell else { return .init()}
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 60, height: 120)
    }
}
