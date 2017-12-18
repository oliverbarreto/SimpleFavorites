//
//  FavoriteGroup.swift
//  SimpleFavorites
//
//  Created by David Oliver Barreto Rodríguez on 18/11/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit



struct FavoriteGroup {
    var name: String!
    var iconImageName: String!
    var color: String!
    var dateCreated: Date!
    
    var description: String {
        
        if let name = self.name, let color = self.color, let iconPath = self.iconImageName, let date = self.dateCreated {
            let str = "Group Name: \(name), Color: \(color), Icon: \(iconPath), created \(date)"
            return str
        }
        return "Empty"
    }
    
    public init(name: String, color: String, iconImageName: String) {
        self.name = name
        self.color = color
        self.iconImageName = iconImageName
        self.dateCreated = Date()
    }
}
