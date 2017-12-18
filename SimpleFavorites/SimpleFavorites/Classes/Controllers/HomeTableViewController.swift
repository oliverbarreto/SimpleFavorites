//
//  HomeTableViewController.swift
//  SimpleFavorites
//
//  Created by David Oliver Barreto Rodríguez on 18/11/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit
import RealmSwift


class HomeTableViewController: UITableViewController {

    // MARK: Outlets
    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var headerTime: UILabel!
    @IBOutlet weak var headerDate: UILabel!
    
    //MARK: Model
//    var groupsModel: Results<Group>!
    private var groupsModel: List<Group>!
    private var groupsModelNotificationToken: NotificationToken?
    
    private var timer: Timer?
    
    // MARK: Constants
    private let kContentInset:       CGFloat = 0.0
    private let kSectionHeaderHight: CGFloat = 55.0
    private let kSectionFooterHight: CGFloat = 100.0
    
    private let cellID = "HomeTableViewControllerCellID"
    private let sectionHeaderCellID = "HomeControllerSectionHeader"
    
    
    // MARK: VC LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        //setupBlurredNavigationBar()
        
        updateTime()

        // Set results notification block
        // Load Realm Model with the list (Groups) associated to the Collection
        let realm = try! Realm()
        groupsModel = realm.object(ofType: Collection.self, forPrimaryKey: "personal")?.groups
        
        print(groupsModel)
        
        self.groupsModelNotificationToken = groupsModel.observe { [weak self] changes in
            
            guard let tableView = self?.tableView else { return }
            
            switch changes {
            case .initial:
                tableView.reloadData()
                break
            case .update(_, let deletions, let insertions, let updates):
                tableView.applyChanges(deletions: deletions, insertions: insertions, updates: updates)
                break
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
                break
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
        // SetupTime
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(updateTime),
                                     userInfo: nil,
                                     repeats: true)
        
        // Timer Notification to update time when the app resuemes to fore round
        NotificationCenter.default.addObserver(self, selector: #selector(updateTime), name: NSNotification.Name.UIApplicationWillEnterForeground, object: UIApplication.shared)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Remove Timer stuff
        NotificationCenter.default.removeObserver(self)
        timer?.invalidate()
        timer = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: Custom Methods
    fileprivate func setupTableView() {
        tableView.contentInset = UIEdgeInsets(top: kContentInset, left: 0, bottom: 0, right: 0)
        
        let nib = UINib(nibName: "HomeControllerSectionHeader", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: sectionHeaderCellID)
    }

    @objc private func updateTime() {
        self.headerTime?.text = getTime()
        self.headerDate?.text = getDate()
    }
    
    private func getDate() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        
        return dateFormatter.string(from: now)
    }
    
    private func getTime() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        return dateFormatter.string(from: now)
    }
    
    private func setupBlurredNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationController?.navigationBar.tintColor = ColorPalette.flatDarken()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueEditCreateFavoriteGroup" {
        
            if let destination = segue.destination as? GroupsEditCreateViewController {
                if let group = sender as? Group {
                    destination.group = group
                } else {
                    destination.group = nil
                }
            }
        }
    }
}

/*
// MARK: - Table view Scrollview Customization for Navbar
extension HomeTableViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let  offset = scrollView.contentOffset.y
        let maxAlpha: CGFloat = 0.9
        let barColor = UIColor.black.hexValue
        let barTintColor = ColorPalette.flatWhite().hexValue
        
        if offset >= (-64 +  70 + 60) {       // initial content offset.y (navbar) + 70 (dateContainerview distance to top) + 50 (where we want to complete fading)
            let color = UIColor(hex: barColor, withAlpha: maxAlpha)
            
            self.navigationController?.navigationBar.backgroundColor = color
            self.navigationController?.navigationBar.tintColor = ColorPalette.flatWhite()
            
            (UIApplication.shared.value(forKey: "statusBar") as? UIView)?.backgroundColor = color
            self.navigationController?.navigationBar.barStyle = .black


        } else if offset > (-64 + 70) && offset < (-64 + 70 + 60){     // initial content offset.y (navbar) + (70 (dateContainerview distance to top) - 70  (where we want it to start fading)
            var alpha: CGFloat = abs(offset / 60) / maxAlpha
            alpha =  alpha > maxAlpha ? maxAlpha : alpha
            let color = UIColor(hex: barColor, withAlpha: alpha)
            let tintColor = UIColor(hex: barTintColor, withAlpha: abs(offset / 60))
            
            self.navigationController?.navigationBar.backgroundColor = color
            self.navigationController?.navigationBar.tintColor = tintColor

            (UIApplication.shared.value(forKey: "statusBar") as? UIView)?.backgroundColor = color
            
        } else {
            let color = ColorPalette.flatWhite()
            
            self.navigationController?.navigationBar.backgroundColor = color
            self.navigationController?.navigationBar.tintColor = ColorPalette.flatDarken()
            (UIApplication.shared.value(forKey: "statusBar") as? UIView)?.backgroundColor = color
        }
    }
}
*/

// MARK: - Table view DataSource
extension HomeTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1    // personal
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! HomeControllerTableViewGroupCell

        // Configure the cell...
        let object = groupsModel[indexPath.row]
        cell.configureCell(withGroup: object)

        return cell
    }
}


// MARK: - Table view Delegate
extension HomeTableViewController {

    // Rows
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = groupsModel[indexPath.row]
        //performSegue(withIdentifier: "segueEditCreateFavoriteGroup", sender: obj)
    }
    
    // Sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kSectionHeaderHight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = Bundle.main.loadNibNamed("HomeControllerTableViewHeaderView", owner: self, options: nil)?.first as! HomeControllerTableViewHeaderView
        view.delegate = self
        
        // FIX: Must call the proper section header name whith data dictionary
        // Configure the cell...
        view.cellLabel?.text = "personal"
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kSectionFooterHight
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let view = Bundle.main.loadNibNamed("HomeControllerTableViewFooterView", owner: self, options: nil)?.first as! HomeControllerTableViewFooterViewProgrammatically
        let view = HomeControllerTableViewFooterViewProgrammatically()
        view.delegate = self
        
        return view
    }
}

// MARK: - Table view Delegates

extension HomeTableViewController: HomeControllerHeaderViewCellDelegate {
    
    func addGroupsButtonWasPressed(cell: HomeControllerTableViewHeaderView) {
        //print("segueEditCreateFavoriteGroup called from \(cell.cellLabel.text!)")
        performSegue(withIdentifier: "segueCreateFavoriteGroup", sender: nil )
    }
}

extension HomeTableViewController: HomeControllerFooterViewCellDelegateprogrammatically {
    func editGroupsButtonWasPressed(cell: UIView) {
        //print("Edit button was pressed")
        performSegue(withIdentifier: "segueEditListOfGroups", sender: nil)
    }
    
    func editGroupsButtonWasPressed(cell: HomeControllerTableViewFooterView) {
        //print("Edit button was pressed")
        performSegue(withIdentifier: "segueEditListOfGroups", sender: nil)
    }
}






