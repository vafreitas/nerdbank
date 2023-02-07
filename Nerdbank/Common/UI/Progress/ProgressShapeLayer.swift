//
//  ProgressShapeLayer.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 11/12/22.
//

import UIKit

class ProgressShapeLayer: CAShapeLayer {
    
    // MARK: Initializer
    
    public init(strokeColor: UIColor, lineWidth: CGFloat) {
        super.init()
        
        self.strokeColor = strokeColor.cgColor
        self.lineWidth = lineWidth
        self.fillColor = UIColor.clear.cgColor
        self.lineCap = .round
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
