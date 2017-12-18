//
//  Collection.swift
//  SimpleFavorites
//
//  Created by David Oliver Barreto Rodríguez on 9/12/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import Foundation
import RealmSwift

public class Collection: Object {
        
    // MARK: Dynamic Properties & Persisted
    @objc dynamic var name: String = ""
    let groups = List<Group>()
    
    // MARK: Meta Properties
    @objc dynamic var collectionID: String = NSUUID().uuidString
    @objc dynamic var dateCreated: Date = Date()
    
    // MARK: Init
    public convenience init(name: String) {
        self.init()
        self.name = name
    }
    
    // MARK: Methods
    public override var description: String {
        let str = "CollectionID(\(collectionID) -- created \(dateCreated): Name: \(name)"
        return str
    }
    
    // MARK: Override (primaryKey, indexedProperties, ignoredProperties)
    public override static func primaryKey() -> String {
        return "name"
    }

    /*
    override static func indexedProperties() -> [String] {
        return ["name", "id"]
    }
    
    override static func ignoredProperties() -> [String] {
        return ["name", "id"]
    }
    */
}

