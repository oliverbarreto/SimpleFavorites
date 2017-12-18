//
//  Theme.swift
//  SimpleFavorites
//
//  Created by David Oliver Barreto Rodríguez on 8/12/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit


protocol ThemeAdopting {
    
    // This function will be called everytime a change notification is received when the theme changes
    func reloadTheme()
}



class Theme {
    
    private static let themeDidChangeNotification = "ThemeDidChangeNotification"

    // MARK: Types
    enum BarColorMode: Int {
        case Dark = 0 , Ligth
    }
    
    enum TextColorMode: Int {
        case Dark = 0, Ligth
    }
    
    enum StatusBarMode: Int {
        case Dark = 0, Light = 1
    }
    
    
    // MARK: Shared Properties
    private static let sharedThemeInstance = Theme()
    
    
    // MARK: Properties
    public var tintColor: UIColor
    public var barColor: UIColor
    public var statusbarColor: UIColor
    
    
    // MARK: Initialization
    private init() {
        self.tintColor = ColorPalette.iosDefaultTintColor()
        self.barColor = ColorPalette.iosDefaultNavbarColor()
        self.statusbarColor = UIColor.white
    }
    
    
    // MARK: Accesssors
    static func shared() -> Theme {
        return sharedThemeInstance
    }
    
    static var themeDidChangeNotificationIdentifier: String {
        return themeDidChangeNotification
    }
    
    
    // MARK: Methods
    
    // Notifies of every change on the theme
    private func notifyObservers() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Theme.themeDidChangeNotificationIdentifier), object: nil, userInfo: [:])
    }
}
