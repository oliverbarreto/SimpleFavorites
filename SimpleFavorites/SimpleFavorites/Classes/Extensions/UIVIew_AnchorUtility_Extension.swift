//
//  UIVIew_AnchorUtility_Extension.swift
//  OnboardingWorkflow
//
//  Created by David Oliver Barreto Rodríguez on 24/12/16.
//  Copyright © 2016 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit

extension UIView {
    
    public func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        // You can create custom views using:
        // YourView.roundCorners([.topLeft, .bottomLeft], radius: 10)
        
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    

    
    // Pin Views helper functions
    
    public func pin(to view: UIView) {
        // Pin a view with anchors to the edges of the passed view
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    public func pinCentered(to view: UIView) {
        // Pin a view with anchors by centering in the passed view
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    public func pinBackgroundView(toStackView stackView:UIStackView) {
        stackView.insertSubview(self, at: 0)
        self.pin(to: stackView)
    }

    
    // Pin Views with Custom Anchors helper functions
    
    public func anchorTo(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom:NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil) {
        
        anchorWithConstantsTo(top: top, left: left, bottom: bottom, right: right, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
    }
    
    
    public func anchorWithConstantsTo(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom:NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0)  {
        
        _ = anchorWithSizeAndConstantsTo(top: top, left: left, bottom: bottom, right: right, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant)
    }
    
    
    //: AnchorWithConstraintsTo - Utility Method
    public func anchorWithSizeAndConstantsTo(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom:NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leadingConstant: CGFloat = 0, bottomConstant: CGFloat = 0, trailingConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint]? {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(self.topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        if let leading = leading {
            anchors.append(self.leadingAnchor.constraint(equalTo: leading, constant: leadingConstant))
        }
        if let bottom = bottom {
            anchors.append(self.bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        if let trailing = trailing {
            anchors.append(self.trailingAnchor.constraint(equalTo: trailing, constant: -trailingConstant))
        }
        if widthConstant > 0 {
            anchors.append(self.widthAnchor.constraint(equalToConstant: widthConstant))
        }
        if heightConstant > 0 {
            anchors.append(self.heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    //: AnchorWithConstraintsTo Using Left, Right Anchors instead of Leading and Trailing - Utility Method
    public func anchorWithSizeAndConstantsTo(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom:NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint]? {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(self.topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        if let left = left {
            anchors.append(self.leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        if let bottom = bottom {
            anchors.append(self.bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        if let right = right {
            anchors.append(self.rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        if widthConstant > 0 {
            anchors.append(self.widthAnchor.constraint(equalToConstant: widthConstant))
        }
        if heightConstant > 0 {
            anchors.append(self.heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
}

