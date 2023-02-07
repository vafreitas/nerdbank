//
//  File.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 11/12/22.
//

import UIKit

class ProgressView: UIView {
    
    // MARK: Animations
    
    let startAnimation = StrokeAnimation(type: .start, beginTime: 0.25, fromValue: 0.0, toValue: 1.0, duration: 0.75)
    let endAnimation = StrokeAnimation(type: .end, fromValue: 0.0, toValue: 1.0, duration: 0.75)
    
    // MARK: Properties
    
    let colors: [UIColor]
    let lineWidth: CGFloat
    
    private lazy var shapeLayer: ProgressShapeLayer = {
         return ProgressShapeLayer(strokeColor: colors.first!, lineWidth: lineWidth)
     }()
    
    var isAnimating: Bool = false {
        didSet {
            if isAnimating {
                self.animateStroke()
                self.animateRotation()
            } else {
                self.shapeLayer.removeFromSuperlayer()
                self.layer.removeAllAnimations()
            }
        }
    }
    
    // MARK: Initializer
    
    init(frame: CGRect, colors: [UIColor], lineWidth: CGFloat) {
        self.colors = colors
        self.lineWidth = lineWidth
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    convenience init(colors: [UIColor], lineWidth: CGFloat) {
        self.init(frame: .zero, colors: colors, lineWidth: lineWidth)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
        
        let path = UIBezierPath(ovalIn:
                .init(x: 0, y: 0, width: bounds.width, height: bounds.height)
        )
        
        shapeLayer.path = path.cgPath
    }
    
    // MARK: Animation Functions
    
    func animateStroke() {
        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = 1
        strokeAnimationGroup.repeatDuration = .infinity
        strokeAnimationGroup.animations = [startAnimation, endAnimation]
        shapeLayer.add(strokeAnimationGroup, forKey: nil)
        
        let colorAnimation = StrokeColorAnimation(
            colors: colors.map { $0.cgColor },
            duration: strokeAnimationGroup.duration * Double(colors.count)
        )
        
        shapeLayer.add(colorAnimation, forKey: nil)
        layer.addSublayer(shapeLayer)
    }
    
    func animateRotation() {
        let rotationAnimation = RotationAnimation(direction: .z, fromValue: 0, toValue: CGFloat.pi * 2, duration: 2, repeatCount: .greatestFiniteMagnitude)
        self.layer.add(rotationAnimation, forKey: nil)
    }
}
