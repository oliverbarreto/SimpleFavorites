//
//  IconSet.swift
//  PersonalFavs
//
//  Created by David Oliver Barreto Rodríguez on 25/6/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit


struct IconSet {
    
    let name:       String
    let iconName:   String
    
    static func groupIcons() -> [IconSet] {
        return [
            IconSet(name: "Default", iconName: "Icon_Group_FriendsGroup3"),
            IconSet(name: "Friends", iconName: "Icon_Group_FriendsGroup2"),
            
            IconSet(name: "Family", iconName: "Icon_Group_Family"),
            IconSet(name: "Family", iconName: "Icon_Group_Family2"),
            IconSet(name: "Family", iconName: "Icon_Group_Family4"),
        
            IconSet(name: "Work", iconName: "Icon_Group_Work"),
            
            IconSet(name: "Earth", iconName: "Icon_Group_Earth"),
            
            IconSet(name: "Romance", iconName: "Icon_Group_Romance"),
            IconSet(name: "Love", iconName: "Icon_Group_Heart-outline"),
            IconSet(name: "Love", iconName: "Icon_Group_Heart"),
            
            IconSet(name: "Gym", iconName: "Icon_Group_Gym"),
            IconSet(name: "Sport", iconName: "Icon_Group_Sports"),
            IconSet(name: "Basketball", iconName: "Icon_Group_Basketball-outline"),
            IconSet(name: "Fotball", iconName: "Icon_Group_Foottball-outline")
            
            // School... ???
        ]
    }
    
    var description: String {
        return "Name: \(name), Icon Name: \(iconName)"
    }
    
    
}
