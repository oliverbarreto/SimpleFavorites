//
//  IndexPath_Extension.swift
//  SimpleFavorites
//
//  Created by David Oliver Barreto Rodríguez on 15/12/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import Foundation

extension IndexPath {
    static func fromRow(_ row: Int) -> IndexPath {
        return IndexPath(row: row, section: 0)
    }
}
