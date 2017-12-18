//
//  HomeControllerTableViewFooterView.swift
//  SimpleFavorites
//
//  Created by David Oliver Barreto Rodríguez on 17/12/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit

// Protocol used to return the key pressed back to the presenter controller
protocol HomeControllerFooterViewCellDelegate {
    func editGroupsButtonWasPressed(cell: HomeControllerTableViewFooterView)
}


class HomeControllerTableViewFooterView: UIView {

    // MARK: - Model
    var delegate: HomeControllerFooterViewCellDelegate?
    
    // MARK: IBOutlets
    @IBOutlet weak var sectionButton: UIButton!
    
    // MARK: IBActions
    @IBAction func editButtonWasPressed(_ sender: UIButton) {
        delegate?.editGroupsButtonWasPressed(cell: self)
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        // Common init goes here
    }
    
    //MARK: - View Lifecycle
    override func layoutSubviews() {
        // Common Setup goes here
        sectionButton?.setTitle("edit", for: .normal)
        sectionButton?.setTitleColor(ColorPalette.flatDarken(), for: .normal)
        sectionButton?.backgroundColor = UIColor.clear
        
//        sectionButton?.layer.cornerRadius = 25
//        sectionButton?.layer.borderWidth = 1
//        sectionButton?.layer.borderColor = ColorPalette.flatDarken().cgColor
    }
    
    // MARK: - Custom

}
