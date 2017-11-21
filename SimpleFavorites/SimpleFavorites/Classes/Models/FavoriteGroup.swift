//
//  FavoriteGroup.swift
//  SimpleFavorites
//
//  Created by David Oliver Barreto Rodríguez on 18/11/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit

struct FavoriteGroup {
    var name: String?
    var iconPath: String?
    var color: String?
    
    var description: String {
        
        if let name = self.name, let color = self.color, let iconPath = self.iconPath {
            let str = "Group Name: \(name), Color: \(color), Icon: \(iconPath)"
            return str
        }
        return "Empty"
    }
}
