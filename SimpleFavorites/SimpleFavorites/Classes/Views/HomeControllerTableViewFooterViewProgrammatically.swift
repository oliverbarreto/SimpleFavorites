//
//  HomeControllerTableViewFooterViewProgrammatically.swift
//  SimpleFavorites
//
//  Created by David Oliver Barreto Rodríguez on 17/12/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit


protocol HomeControllerFooterViewCellDelegateprogrammatically {
    func editGroupsButtonWasPressed(cell: UIView)
}


class HomeControllerTableViewFooterViewProgrammatically: UIView {

    // MARK: - Model
    var delegate: HomeControllerFooterViewCellDelegateprogrammatically?
    
    // MARK: Prgrammatically UI elements
    lazy var sectionButton: UIButton = {
        let button = UIButton()
        button.setTitle("edit", for: .normal)
        button.setTitleColor(ColorPalette.flatDarken(), for: .normal)
        button.addTarget(self, action: #selector(self.editButtonWasPressed), for: .touchUpInside)
        button.backgroundColor = UIColor.clear
        button.layer.cornerRadius = 25
        button.layer.borderColor = ColorPalette.flatDarken().cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
    }
    
    private func setupViews() {
        // Common init goes here
        
        addSubview(sectionButton)
        
        _ = sectionButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        _ = sectionButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        _ = sectionButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        _ = sectionButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    // MARK: - Custom
    @objc func editButtonWasPressed(sender: UIView) {
        delegate?.editGroupsButtonWasPressed(cell: self)
    }

}
