//
//  GroupEditListOfGroupsTableViewCell.swift
//  SimpleFavorites
//
//  Created by David Oliver Barreto Rodríguez on 17/12/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit

class GroupEditListOfGroupsTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var groupCardView: MaterialDesignCardView!
    @IBOutlet weak var groupCardIconImageView: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
    
    // MARK: Model
    var group: Group? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: Customization
    public func configureCell(withGroup sender: Group) {
        group = sender
    }
    
    private func updateUI() {
        guard let name = group?.name,
        let color = group?.color,
            let iconName = group?.iconName else { return }
        
        groupCardView.backgroundColor = UIColor(hex: color)
        groupCardIconImageView.image = UIImage(named: iconName)
        groupNameLabel.text = name
    }
}
