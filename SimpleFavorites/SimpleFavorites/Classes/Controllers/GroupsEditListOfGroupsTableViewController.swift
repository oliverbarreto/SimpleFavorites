//
//  GroupsEditListOfGroupsTableViewController.swift
//  SimpleFavorites
//
//  Created by David Oliver Barreto Rodríguez on 15/12/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit
import RealmSwift


class GroupsEditListOfGroupsTableViewController: UITableViewController {

    //MARK: Model
    var groupsModel: List<Group>!
    
    // MARK: Constants
    private let cellID = "EditListOfGroupsTableViewControllerCellID"
    
    //MARK: VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorPalette.flatWhite()

        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Load Realm Model with the list (Groups) associated to the Collection
        let realm = try! Realm()
        groupsModel = realm.object(ofType: Collection.self, forPrimaryKey: "personal")?.groups
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension GroupsEditListOfGroupsTableViewController {
    
    // MARK: UITableView DataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! GroupEditListOfGroupsTableViewCell
        
        // Configure the cell...
        let object = groupsModel[indexPath.row]
        //cell.textLabel?.text = object.name
        cell.configureCell(withGroup: object)
        
        return cell
    }
    
    
    //MARK: UITableView Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
   
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let object = groupsModel[indexPath.row]
            RealmDataService.shared.delete(object)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let object = groupsModel[sourceIndexPath.row]
        let realm = try! Realm()
        try! realm.write {
            groupsModel.remove(at: sourceIndexPath.row)
            groupsModel.insert(object, at: destinationIndexPath.row)
        }
    }
    
    // Cell Selection
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = groupsModel[indexPath.row]
        performSegue(withIdentifier: "segueEditFavoriteGroup", sender: object)
    }
    
}



