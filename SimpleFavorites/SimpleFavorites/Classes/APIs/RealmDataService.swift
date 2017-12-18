//
//  RealmDataService.swift
//  SimpleFavorites
//
//  Created by David Oliver Barreto Rodríguez on 9/12/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDataService {

    private static let realmErrorNotificationString = "RealmError"
    
    // MARK: - Properties
    private static let sharedRealmDataService = RealmDataService()
    public var realm = try! Realm()
    
    // Initialization
    private init() {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    // MARK: - Accessors
    public static var shared: RealmDataService {
        return sharedRealmDataService
    }
    
    // MARK: Custom CRUD Methods
    public func create<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            postError(error)
            //print(error.localizedDescription)
        }
    }
    
    public func readAll<T: Object>(_ object: T.Type) -> Results<T> {
        do {
            return try realm.objects(object)
        } catch  {
            postError(error)
        }
        
    }
    
    public func update<T: Object>(_ object: T, with dictionary: [String: Any?]) {
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch  {
            postError(error)
        }
    }
    
    public func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch  {
            postError(error)
        }
    }
    
    
    // MARK: Utility Methods
    private func postError(_ error: Error) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: RealmDataService.realmErrorNotificationString), object: error)
    }
    
    private func startObservingRealmErrors(in observer: UIViewController, completion: @escaping (Error?) -> Void) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: RealmDataService.realmErrorNotificationString),
                                               object: nil,
                                               queue: nil) { (notification) in
                                                completion(notification.object as? Error)
        }
    }
    
    private func stopObservingRealmErrors(in observer: UIViewController) {
        NotificationCenter.default.removeObserver(observer, name: NSNotification.Name(rawValue: RealmDataService.realmErrorNotificationString), object: nil)
    }
    
    //MARK: Load Initial Data
    public func loadInitialData() {
        do {
            let collection1 = Collection(name: "personal")
            let collection2 = Collection(name: "shared")
            let collection3 = Collection(name: "recommended")
            
            let group1 = Group(name: "family", color: ColorPalette.flatAmethyst().hexValue, iconName: "Icon_Group_FriendsGroup3")
            
            let group2 = Group(name: "work", color: ColorPalette.flatDarken().hexValue, iconName: "Icon_Group_FriendsGroup3")
            
            let group3 = Group(name: "basketball", color: ColorPalette.flatCarrot().hexValue, iconName: "Icon_Group_FriendsGroup3")
            
            collection1.groups.append(group1)
            collection1.groups.append(group2)
            collection1.groups.append(group3)
            
            try realm.write {
                realm.add(group1)
                realm.add(group2)
                realm.add(group3)
                realm.add(collection1)
                realm.add(collection2)
                realm.add(collection3)
            }
        } catch  {
            postError(error)
        }
    }
}
