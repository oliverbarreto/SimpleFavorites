//
//  UITableView_Extension.swift
//  SimpleFavorites
//
//  Created by David Oliver Barreto Rodríguez on 15/12/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit
import RealmSwift


extension UITableView {
    
    // This is the primary way of using fine-grained notifications
    // https://academy.realm.io/posts/live-objects-fine-grained-notifications-realm-update/
    func applyChanges(section: Int = 0, deletions: [Int], insertions: [Int], updates: [Int]) {
        
        beginUpdates()
        deleteRows(at: deletions.map {IndexPath(row: $0, section:0)}, with: .automatic)
        insertRows(at: insertions.map {IndexPath(row: $0, section:0)}, with: .automatic)
        reloadRows(at: updates.map {IndexPath(row: $0, section:0)}, with: .none)
        endUpdates()
    }
    
    func applyChanges<T>(for changes: RealmCollectionChange<T>) {
        //let token = myResults.observe(tableView.applyChanges)

        switch changes {
            case .initial:
                reloadData()
                break
            case .update(_, let deletions, let insertions, let updates):
                let fromRow = {(row: Int) in
                    return IndexPath(row: row, section: 0)
                }
                
                beginUpdates()
                deleteRows(at: deletions.map(fromRow), with: .automatic)
                insertRows(at: insertions.map(fromRow), with: .automatic)
                reloadRows(at: updates.map(fromRow), with: .none)
                endUpdates()
                break
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
                break
        }
    }
}
