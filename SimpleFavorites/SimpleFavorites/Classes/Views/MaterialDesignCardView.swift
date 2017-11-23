//
//  MaterialDesignCardView.swift
//  SimpleFavorites
//
//  Created by David Oliver Barreto Rodríguez on 21/11/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit

@IBDesignable
class MaterialDesignCardView: UIView {

    // MARK: Config
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            updateUI()
        }
    }
    
    @IBInspectable
    var hasShadow: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? = .gray {
        didSet {
            updateUI()
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float = 0.8 {
        didSet {
            updateUI()
        }
    }
    
    @IBInspectable
    var shadowOffsetX: CGFloat = 0 {
        didSet {
            updateUI()
        }
    }
    
    @IBInspectable
    var shadowOffsetY: CGFloat = 2 {
        didSet {
            updateUI()
        }
    }
    
    
    // MARK: INitialization
    required init?(coder aDecoder: NSCoder) {       // To init from IB
        super.init(coder: aDecoder)
        customInit()
    }
    
    override init(frame: CGRect) {                  // To init from Code
        super.init(frame: frame)
        customInit()
    }
    
    fileprivate func customInit() {
        updateUI()
    }

    
    // MARK: Custom

    fileprivate func updateUI() {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        
        if hasShadow {
            self.layer.shadowOpacity = shadowOpacity
//            self.layer.shadowOpacity = 0.8
            self.layer.shadowRadius = cornerRadius
            self.layer.shadowOffset = CGSize(width: shadowOffsetX, height: shadowOffsetY)
            self.layer.shadowColor = shadowColor?.cgColor
        } else {
            self.layer.shadowOpacity = 0.8
            self.layer.shadowRadius = 0.0
            self.layer.shadowOffset = CGSize.zero
            self.layer.shadowColor = nil
        }
        
    }
    
}
