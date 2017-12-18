//
//  GroupsEditCreateViewController
//  SimpleFavorites
//
//  Created by David Oliver Barreto Rodríguez on 21/11/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit
import RealmSwift


class GroupsEditCreateViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var groupCard: UIView!
    @IBOutlet weak var groupCardName: UILabel!
    @IBOutlet weak var groupCardIcon: UIImageView!
    
    @IBOutlet weak var groupContainerView: UIView!
    @IBOutlet weak var groupNameTextField: UITextField!

    @IBOutlet weak var groupColorButton: UIButton!
    @IBOutlet weak var groupColorPickerContainerView: UIView!
    @IBOutlet weak var groupColorPickerView: UIPickerView!
    
    @IBOutlet weak var groupIconButton: UIButton!
    @IBOutlet weak var groupIconPickerContainerView: UIView!
    @IBOutlet weak var groupIconPickerView: UIPickerView!
    
    @IBOutlet weak var okButton: UIButton!
 
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    // MARK: Constants
    private let inputControlsTextColor          = ColorPalette.flatDarken()
    private let inputContainerViewDefaultColor  = ColorPalette.flatPorcelain()
    private let groupCardDefaultColor           = ColorPalette.flatRazzmatazz()
    private let okButtonDefaultColor            = ColorPalette.flatRazzmatazz()
    private let groupNameDefaultCaptionText     = "group name"
    private let groupColorDefaultCaptionText    = "set a color"
    private let groupIconDefaultCaptionText     = "set an icon"
    private let groupCardDefaultIconPath        = "Icon_Group_Default"
    
    // MARK: Model
    var group: Group?
    
    // MARK: Dynamic Properties
    private var userHasEditedGroupName: Bool {
        get {
            guard let text = groupNameTextField.text else {return false}
            if text != groupNameDefaultCaptionText, text != "" {
                return true
            } else {
                return false
            }
        }
    }
    
    //MARK: VC LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UIPickers' Delegates
        groupColorPickerView.dataSource = self
        groupColorPickerView.delegate = self
        
        groupIconPickerView.dataSource = self
        groupIconPickerView.delegate = self
        
        // UITextField's Delegates
        groupNameTextField.delegate = self
        
        // Customization
        setupViews()
        updateUI()
        
        customNavBar()
    }
    
    private func updateUI() {
        
        // Programmatically set UI colors & texts
        groupNameTextField.textColor = inputControlsTextColor
        groupColorButton.setTitleColor(inputControlsTextColor, for: .normal)
        groupIconButton.setTitleColor(inputControlsTextColor, for: .normal)
        
        if let group = self.group {
            print(group)
            self.navigationItem.title = "Edit"
            groupCard.backgroundColor = UIColor(hex: group.color)
            groupContainerView.backgroundColor = ColorPalette.flatWhite()
            
            groupNameTextField.text = group.name
            groupColorButton.setTitle(group.color, for: .normal)
            groupIconButton.setTitle(group.iconName, for: .normal)
            
        } else {
            self.navigationItem.title = "Create a Group"
            groupCard.backgroundColor = groupCardDefaultColor
            groupContainerView.backgroundColor = inputContainerViewDefaultColor
    
            groupNameTextField.placeholder = groupNameDefaultCaptionText
            groupColorButton.setTitle(groupColorDefaultCaptionText, for: .normal)
        }
    }

    private func customNavBar() {
        
        self.view.backgroundColor = ColorPalette.flatWhite()
        
        // Navbar Tint Colors
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        // Set Navbar Background color to group color
        UINavigationBar.appearance().barTintColor = UIColor(hex: ColorPalette.flatRazzmatazz().hexValue)
        
    }
    
    private func setupViews() {
        
        // Custom UINavigation BackButton
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Icon_ChevronLeft") , style: .plain, target: self, action: #selector(backButtonPressed))
        
        // Programmatically set UI colors & text
        contentView.backgroundColor = .white
        
        // Hide Pickers' Container Views
        groupColorPickerContainerView.isHidden = true
        groupIconPickerContainerView.isHidden = true
        
        groupIconButton.setTitleColor(inputControlsTextColor, for: .normal)
        groupIconButton.setTitle(groupIconDefaultCaptionText, for: .normal)
        
        okButton.isHidden = true
        okButton.setTitleColor(okButtonDefaultColor, for: .normal)
    }
    
    // MARK: IBActions
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: IBActions
    @IBAction func setColorButtonPressed(_ sender: UIButton) {
        //print("set color button pressed")
        if groupColorPickerContainerView.isHidden {
            showHidePickerContainerView(containerView: groupColorPickerContainerView, show: true)
            showHidePickerContainerView(containerView: groupIconPickerContainerView, show: false)
        } else {
            showHidePickerContainerView(containerView: groupColorPickerContainerView, show: false)
        }
    }
    
    @IBAction func setIconButtonPressed(_ sender: UIButton) {
        //print("set icon button pressed")
        if groupIconPickerContainerView.isHidden {
            showHidePickerContainerView(containerView: groupIconPickerContainerView, show: true)
            showHidePickerContainerView(containerView: groupColorPickerContainerView, show: false)
        } else {
            showHidePickerContainerView(containerView: groupIconPickerContainerView, show: false)
        }
    }
    
    @IBAction func okButtonPRessed(_ sender: UIButton) {
        showHidePickerViewsIfNeeded()
        
        validateAndSave()
    }
    
    // MARK : Custom Methods
    @objc fileprivate func backButtonPressed() {
        //print("back button pressed")
        if userHasEditedGroupName {
            let alert = UIAlertController(title: "Alert", message: "are you sure you want to discard this group?", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "yes", style: UIAlertActionStyle.destructive) {
                (result : UIAlertAction) -> Void in
                self.navigationController?.popViewController(animated: true)
            })
            alert.addAction(UIAlertAction(title: "no", style: UIAlertActionStyle.default) {
                (result : UIAlertAction) -> Void in
            })
            self.present(alert, animated: true, completion: nil)
            
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    
    fileprivate func validateAndSave() {
        
        guard let name = groupNameTextField.text,
            var color = groupColorButton.titleLabel?.text,
            var iconImageName = groupIconButton.titleLabel?.text else { return }

        let realm = try! Realm()

        if group != nil {
            
            // TODO: Edit...
            let object = realm.objects(Group.self).filter("name = %@", name)
            print(object)
//            let changes = ["name": object.name, "color": object.color, "iconName": object.iconName]
//            RealmDataService.shared.update(object, with: changes)
//            let collection = realm.objects(Collection.self).filter("name = %@", "personal").first!
//            try! realm.write {
//                collection.groups.append(group!)
//            }

            
        } else {
            if validateGroup() {
                
                // TODO: Save...
                if color == groupColorDefaultCaptionText {
                    color = groupCardDefaultColor.hexValue
                    
                } else {
                    color = color.replacingOccurrences(of: " color", with: "")
                    let colorsArray = ColorPalette.flatPalette()
                    if let colorObject = colorsArray.first(where: {$0.name.lowercased() == color.lowercased()}) {
                        color = colorObject.color.hexValue
                    } else {
                        color = "#111111"
                    }
                }
                
                var nameString = groupCardDefaultIconPath
                if let iconName = IconSet.iconImageName(withIconName: iconImageName.replacingOccurrences(of: " icon", with: "")) {
                    nameString = iconName
                }
                
//                if iconImageName == groupIconDefaultCaptionText {
//                    iconName = groupCardDefaultIconPath
//                } else {
//                    iconName = IconSet.iconImageName(withIconName: iconName)
//                    iconImageName = "Icon_Group_\(iconImageName.capitalized.replacingOccurrences(of: " Icon", with: ""))"
//                }
//
                let group = Group(name: name, color: color, iconName:nameString)
                
                print(group)
                
                // Create the Group and assign it to the Collection list
                RealmDataService.shared.create(group)
                let collection = realm.objects(Collection.self).filter("name = %@", "personal").first!
                try! realm.write {
                    collection.groups.append(group)
                }
            }
            // Pop Navigation to go back
            self.navigationController?.popViewController(animated: true)
            //self.dismiss(animated: true, completion: nil)
        }
        

    }
    
    fileprivate func validateGroup() -> Bool {
        
        guard let name = groupNameTextField.text,
            let _ = groupColorButton.titleLabel?.text,
            let _ = groupIconButton.titleLabel?.text else { return false }

        if name == "" || name == groupNameDefaultCaptionText { return false }
        
        return true
    }
    
    fileprivate func validateGroupToShowHideOKButton() {
        if userHasEditedGroupName {
            okButton.isHidden = false
        } else {
            okButton.isHidden = true
        }
        
    }
    
    fileprivate func showHidePickerContainerView(containerView viewToAnimate: UIView, show: Bool) {
        //print("show: \(show)")
        var alpha: CGFloat = 1.0
        if !show {
            alpha = 0.0
        }
        UIView.animate(withDuration: 0.3, animations: { [weak viewToAnimate] in
            viewToAnimate?.alpha = alpha
            }, completion: { (_) in
                viewToAnimate.isHidden = !show
        })
        
    }
    
    fileprivate func showHidePickerViewsIfNeeded() {
        if self.groupColorPickerContainerView.isHidden == false {
            showHidePickerContainerView(containerView: groupColorPickerContainerView, show: false)
        }
        
        if self.groupIconPickerContainerView.isHidden == false {
            showHidePickerContainerView(containerView: groupIconPickerContainerView, show: false)
        }
    }
}



// MARK: UITextFileds delegate
extension GroupsEditCreateViewController: UITextFieldDelegate {
    
    // Recognizes touches outside the textfield and hides the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
        showHidePickerViewsIfNeeded()
        if let name = groupNameTextField.text {
            groupCardName.text = name
        }
        
        validateGroupToShowHideOKButton()
        
        super.touchesBegan(touches, with: event)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            textField.resignFirstResponder()
            if textField.text != "" {
                groupCardName?.text = textField.text
                validateGroupToShowHideOKButton()
            }
        }
        // change focus to the next field, nextfield.becomefirstresponder()
        //groupColorTextField.becomeFirstResponder()

        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // customize the behavior of the application: e.g. change the background color of the text field changes when this method is called to indicate the text field is active
        showHidePickerViewsIfNeeded()

        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // customize the behavior of the application: e.g. revert the changes made to the background color of the text field changes when this method is called to indicate the text field is in-active
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // validate group info to show ok button to save info
        validateGroupToShowHideOKButton()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Helps to intercept characters when they are typed into the keyboard.... e.g. don't allow #'s
        if (string == "#") { return false } else { return true }
        
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        //textFieldShouldClear: is called when the user presses the clear button, the gray "x," inside the text field. Before the active text field is cleared, this method gives you an opportunity to make any needed customizations.
        return true
    }
}

// MARK: Picker's delegate & datasource
extension GroupsEditCreateViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView.tag {
        case 1:         // Tag 1: Color
            return ColorPalette.numberOfColors(InPalette: .flatColors)
        case 2:         // Tag 1: Icon
            return IconSet.groupIcons().count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        switch pickerView.tag {
            
        case 1:       // Tag 1: Color
            return NSAttributedString(string: ColorPalette.flatPalette()[row].name,
                               attributes: [NSAttributedStringKey.foregroundColor : inputControlsTextColor, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin)])
        case 2:       // Tag 2: Icon
            return NSAttributedString(string: IconSet.groupIcons()[row].name,
                                      attributes: [NSAttributedStringKey.foregroundColor : inputControlsTextColor, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin)])
        default:
            return  NSAttributedString(string: "",
                                       attributes: [NSAttributedStringKey.foregroundColor : inputControlsTextColor, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin)])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
            
        case 1:
            let color = ColorPalette.flatPalette()[row]
            groupCard?.backgroundColor = color.color
            groupColorButton?.setTitle("\(color.name.lowercased()) color", for: .normal)
        case 2:
            let icon = IconSet.groupIcons()[row]
            groupCardIcon?.image = UIImage(named: icon.iconName)
            groupIconButton?.setTitle("\(icon.name.lowercased()) icon", for: .normal)
            
        default:
            return
        }
    }
}



