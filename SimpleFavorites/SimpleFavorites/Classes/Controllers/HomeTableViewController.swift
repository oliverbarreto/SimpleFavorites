//
//  HomeTableViewController.swift
//  SimpleFavorites
//
//  Created by David Oliver Barreto Rodríguez on 18/11/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    // MARK: Outlets
    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var headerTime: UILabel!
    @IBOutlet weak var headerDate: UILabel!
    
    
    //MARK: Model
    let model = ["family", "work", "basketball"]
    
    private var timer: Timer?
    
    // MARK: Constants
    private let kContentInset:       CGFloat = 0.0
    private let kSectionHeaderHight: CGFloat = 50.0
    
    fileprivate let cellID = "HomeTableViewControllerCellID"
    fileprivate let sectionHeaderCellID = "HomeControllerSectionHeader"
    
    
    // MARK: VC LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        updateTime()
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

    @objc fileprivate func updateTime() {
        self.headerTime?.text = getTime()
        self.headerDate?.text = getDate()
    }
    
    fileprivate func getDate() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        
        return dateFormatter.string(from: now)
    }
    
    fileprivate func getTime() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        return dateFormatter.string(from: now)
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! HomeControllerTableViewGroupCell

        // Configure the cell...
        cell.groupName.text = model[0]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = Bundle.main.loadNibNamed("HomeControllerTableViewHeaderView", owner: self, options: nil)?.first as! HomeControllerTableViewHeaderView
        view.delegate = self
        
        // FIX: Must call the proper section header name whit data dictionary
        view.cellLabel?.text = "personal"
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kSectionHeaderHight
    }

    /*
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(tableView.contentOffset.y)
        if tableView.contentOffset.y >= 0 {
            tableView.contentInset = UIEdgeInsets.zero

        } else {
            tableView.contentInset = UIEdgeInsetsMake( min(-tableView.contentOffset.y, kContentInset - kSectionHEaderHight), 0, 0, 0 );

        }
    }
    */

}

extension HomeTableViewController: HomeControllerHeaderViewCellDelegate {
    func addGroupsButtonWasPressed(cell: HomeControllerTableViewHeaderView) {
        
        print(cell.cellLabel.text!)
    }
}






