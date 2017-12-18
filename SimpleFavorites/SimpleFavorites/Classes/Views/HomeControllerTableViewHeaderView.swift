//
//  HomeControllerTableViewHeaderView.swift
//  SimpleFavorites
//
//  Created by David Oliver Barreto Rodríguez on 21/11/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit

// Protocol used to return the key pressed back to the presenter controller
protocol HomeControllerHeaderViewCellDelegate {
    func addGroupsButtonWasPressed(cell: HomeControllerTableViewHeaderView)
}


class HomeControllerTableViewHeaderView: UIView {

    // MARK: Model
    var delegate: HomeControllerHeaderViewCellDelegate?
    
    var sectionName: String? {
        didSet {
            cellLabel?.text = sectionName
        }
    }
    
    // MARK: IBOutlets & IBActions
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellActionButton: UIButton!
    
    @IBAction func cellActionButtomPressed(_ sender: UIButton) {
        delegate?.addGroupsButtonWasPressed(cell: self)
    }
    
    // MARK: Initialization
    override init(frame: CGRect) {              // For initialization of customView in code
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {   // For initialization of customView in IB
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        // Common Setup goes here
    }
    
}
