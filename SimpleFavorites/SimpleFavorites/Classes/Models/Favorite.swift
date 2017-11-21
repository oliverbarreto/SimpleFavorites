//
//  Favorite.swift
//  TestContacts
//
//  Created by David Oliver Barreto Rodríguez on 15/11/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

struct Favorite {
    
    var contactID: String!
    var givenName: String!
    var familyName: String!
    var fullName: String!
    var initials:String!
    var valueType: CommunicationManager.TypesOfFavoriteValue!
    var valueFavActionType: CommunicationManager.ActionType!
    var favValue: String!
    var favLabel: String!
    var hasImage: Bool = false
    var image: UIImage!
    var thumbImage: UIImage!
    
    
    var description: String {
        guard let id = self.contactID, let name = self.givenName, let last = self.familyName, let full = self.fullName, let value = favValue, let label = favLabel, let type = valueType, let favActionType = valueFavActionType, let image = image, let thumbImage = thumbImage else {return ""}
        
        return "Contact ID: \(id), \nName: \(full), \nValue: \(value), \nLabel: \(label), \nType: \(type), \nPreferred Action: \(favActionType), \nisImageAvailable: \(hasImage)"
    }
    
    
    public static func createContact(withContactProperty contactProperty: CNContactProperty) -> Favorite {
        
        // Initials
        let initials = getInitials(withContactProperty: contactProperty)
        var hasImage = false
        var image = UIImage(named: "user")!
        var thumbImage = UIImage(named: "user")!
        
        // Image
        if contactProperty.contact.imageDataAvailable {
            hasImage = true
            if let img = contactProperty.contact.imageData {
                image = UIImage(data: img)!
            }
            if let tmb = contactProperty.contact.thumbnailImageData {
                thumbImage = UIImage(data: tmb)!
            }
        }
        
        // Key & Value
        var valueType = CommunicationManager.TypesOfFavoriteValue.PhoneNumber // Defaults to phone numbers
        var favValue = ""
        var favLabel = ""
        
        // Preferred Value Type
        var preferredActionType = CommunicationManager.ActionType.WhatsApp // Defaults to emails until the implementation of the edit VC
        
        
        // Phone Numbers
        if contactProperty.key == CNContactPhoneNumbersKey {
            valueType = .PhoneNumber
            
            if let value = contactProperty.value as? CNPhoneNumber {
                favValue = value.stringValue
            }
            if let label = contactProperty.label {
                favLabel = Favorite.getLabel(fromCNLabeledValueLabelString: label)
            }
        }
        
        // eMail Addresses
        if contactProperty.key == CNContactEmailAddressesKey {
            valueType = .eMailAddress
            
            if let value = contactProperty.value as? String {
                favValue = value
            }
            if let label = contactProperty.label {
                favLabel = Favorite.getLabel(fromCNLabeledValueLabelString: label)
            }
        }
        
        // URLs
        if contactProperty.key == CNContactUrlAddressesKey {
            valueType = .URL
            
            if let value = contactProperty.value as? String {
                favValue = value
            }
            if let label = contactProperty.label {
                favLabel = Favorite.getLabel(fromCNLabeledValueLabelString: label)
            }
        }
        return Favorite(contactID: contactProperty.identifier,
                           givenName: contactProperty.contact.givenName,
                           familyName:  contactProperty.contact.familyName,
                           fullName: CNContactFormatter.string(from: contactProperty.contact, style: .fullName),
                           initials: initials,
                           valueType: valueType,
                           valueFavActionType: preferredActionType,
                           favValue: favValue,
                           favLabel: favLabel,
                           hasImage: hasImage,
                           image: image,
                           thumbImage: thumbImage)
    }
    
    
    // MARK: Utility Methods
    fileprivate static func getLabel(fromCNLabeledValueLabelString labelString: String) -> String {
        // THis should return a localized version of the lable, but instead it returns a localized string with the key value
         return  CNLabeledValue<NSString>.localizedString(forLabel: labelString).capitalized

      /*
        var label = ""
        
        switch labelString  {
            
        // Generic
        case CNLabelHome:
            label = "Home"
        case CNLabelWork:
            label = "Work"
        case CNLabelOther:
            label = "Other"
            
        // Phone
        case CNLabelPhoneNumberMain:
            label = "Main"
        case CNLabelPhoneNumberiPhone:
            label = "iPhone"
        case CNLabelPhoneNumberMobile:
            label = "Mobile"
        case CNLabelPhoneNumberPager:
            label = "Pager"
        case CNLabelPhoneNumberHomeFax:
            label = "Home Fax"
        case CNLabelPhoneNumberWorkFax:
            label = "Work Fax"
        case CNLabelPhoneNumberOtherFax:
            label = "Other Fax"
            
        // eMail
        case CNLabelEmailiCloud:
            label = "iCloud"
            
        // URL
        case CNLabelURLAddressHomePage:
            label = "Home Page"
            
        // Default
        default:
            label = "Main"
        }
        return label
        */
 
    }
    
    fileprivate static func getInitials(withContactProperty contactProperty: CNContactProperty) -> String {
        var initials = ""
        
        let givenName = contactProperty.contact.givenName
        let familyName = contactProperty.contact.familyName
        
        if (givenName != "" && familyName != "") {
            initials = String(givenName.first!).uppercased()
            initials += String(familyName.first!).uppercased()
            
        } else if (givenName == "" && familyName != "") {
            initials = String(familyName.prefix(2)).uppercased()
            
        } else if (familyName != "") && (familyName == "") {
            initials = String(givenName.prefix(2)).uppercased()
        }
        
        return initials
    }
    
    
}
