//
//  HomeControllerTableViewGroupCell.swift
//  SimpleFavorites
//
//  Created by David Oliver Barreto Rodríguez on 18/11/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit


class HomeControllerTableViewGroupCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var groupCardView: UIView!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupIcon: UIImageView!
    
    // MARK: Model
    var group: Group? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: Customization
    func updateUI() {
        groupName.text = group?.name
        
        if let image = UIImage(named: (group?.iconName)!) {
            groupIcon.image = image.withRenderingMode(.alwaysTemplate)
            
        } else {
            let image = #imageLiteral(resourceName: "Icon_Group_FriendsGroup3").withRenderingMode(.alwaysTemplate)
            groupIcon.image = image
        }
        
        let color = UIColor(hex: (group?.color)!)
        self.groupCardView.backgroundColor = color
    }
    
    public func configureCell(withGroup sender: Group) {
        group = sender
    }
    
    override func layoutSubviews() {
        self.groupCardView.layer.cornerRadius = 5
    }
    
}
