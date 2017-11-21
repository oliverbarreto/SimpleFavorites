//
//  String_Extension.swift
//  PersonalFavs
//
//  Created by David Oliver Barreto Rodríguez on 7/11/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import Foundation

extension String {
    func removeWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    func replace(characterSet set: [(String,String)]) -> String {
        
        var newString = self
        if set.count != 0 && self != "" {
            for pair in set {
                newString = newString.replacingOccurrences(of: pair.0, with: pair.1)
            }
        }
        return newString
    }
}
