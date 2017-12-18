//
//  Group.swift
//  SimpleFavorites
//
//  Created by David Oliver Barreto Rodríguez on 9/12/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import Foundation
import RealmSwift

public class Group: Object {
    
    // MARK: Dynamic Properties & Persisted
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    @objc dynamic var iconName: String = "Icon_Group_FriendsGroup3"
    
    // MARK: Meta Properties
    @objc dynamic var groupID: String = NSUUID().uuidString
    @objc dynamic var dateCreated: Date = Date()
    
    // MARK: Init
    public convenience init(name: String, color: String, iconName: String) {
        self.init()
        self.name = name
        self.color = color
        self.iconName = iconName
    }

    // MARK: Methods
    public override var description: String {
        let str = "GroupID(\(groupID) -- created \(dateCreated): Name: \(name), Color: \(color), Icon: \(iconName)"
        return str        
    }
    
    public override static func primaryKey() -> String {
        return "groupID"
    }
}
