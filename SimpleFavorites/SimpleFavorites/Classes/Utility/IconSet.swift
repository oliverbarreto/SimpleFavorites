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
            IconSet(name: "Default", iconName: "Icon_Group_Default"),
            IconSet(name: "Friends", iconName: "Icon_Group_FriendsGroup2"),
            IconSet(name: "Friends Group", iconName: "Icon_Group_FriendsGroup3"),
            
            IconSet(name: "Family", iconName: "Icon_Group_Family"),
            IconSet(name: "Large Family", iconName: "Icon_Group_Family_4"),
            IconSet(name: "Small Family", iconName: "Icon_Group_Family_2"),
        
            IconSet(name: "Work", iconName: "Icon_Group_Work"),
            
            IconSet(name: "Earth", iconName: "Icon_Group_Earth"),
            
            IconSet(name: "Romance", iconName: "Icon_Group_Romance"),
            IconSet(name: "Love", iconName: "Icon_Group_Heart"),
            IconSet(name: "Love Outline", iconName: "Icon_Group_Heart_Outline"),
            
            IconSet(name: "Restaurants", iconName: "Icon_Group_Restaurants"),

            IconSet(name: "Gym", iconName: "Icon_Group_Gym"),
            IconSet(name: "Sports", iconName: "Icon_Group_Sports"),
            IconSet(name: "Basketball", iconName: "Icon_Group_Basketball"),
            IconSet(name: "Fotball", iconName: "Icon_Group_Foottball")
            
            // School... ???
        ]
    }
    
    var description: String {
        return "Name: \(name), Icon Name: \(iconName)"
    }
    
    public static func iconImageName(withIconName name: String) -> String? {
        if let icon = IconSet.groupIcons().first(where: { $0.name.lowercased() == name.lowercased() }) {
            return icon.iconName
        }
        return nil
    }
}
