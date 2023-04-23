//
//  TransferViewModel.swift
//  Nerdbank
//
//  Created by Victor Freitas on 22/04/23.
//

import Foundation

class TransferViewModel {
    
    // MARK: Properties
    
    var model: TransferModel
    
    // MARK: Initializer
    
    init(model: TransferModel = .init(sections: [])) {
        self.model = model
        self.model.sections = [
            .init(title: "Recentes", options: [
                .init(name: "Claudio")
            ], type: .recents),
            .init(title: "Favoritos", options: [
                .init(name: "Amanda Malaman"),
                .init(name: "Claudinho Bochecha")
            ], type: .favorite)
        ]
    }
}
