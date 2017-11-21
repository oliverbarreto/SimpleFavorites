//
//  ComunicationManager.swift
//  TestContacts
//
//  Created by David Oliver Barreto Rodríguez on 15/11/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit

class CommunicationManager {
    
    // Available Communication Types
    public enum ActionType: String {
        case Call, Text, WhatsApp, FaceTime, FaceTimeAudio, eMail, Web, Maps
        // Skype, Messenger, Twitter ...
    }
    
    public enum TypesOfFavoriteValue: String {
        case eMailAddress, PhoneNumber, URL
        
        public var description: String {
            switch self {
            case .eMailAddress:
                return "eMail Address"
            case .PhoneNumber:
                return "Phone Number"
            case .URL:
                return "URL"
            }
        }
    }
    
    open static let ValidActions: [TypesOfFavoriteValue:[ActionType]] = [.eMailAddress : [.Text, .FaceTime, .FaceTimeAudio, .eMail], .PhoneNumber : [.Call, .Text, .WhatsApp, .FaceTime, .FaceTimeAudio], .URL : [.Web, .Maps]]
    
    
    
    // MARK: - Actions
    
    // Checks whether an app URLScheme is available on the device (the app is installed). after adding LSApplicationQueriesSchemes key toinfo.plist
    fileprivate class func schemeAvailable(scheme: String) -> Bool {
        if let url = URL(string: scheme) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    

    // Cheks if Action is possible to executes with the type of value passed
    fileprivate class func canExecute(action: ActionType, withFavoriteType type: TypesOfFavoriteValue) -> Bool {
        guard let values = ValidActions[type] else { return false }
        return values.contains(action)
    }
    
    // Execute action with value if possible, with its value type
    public class func execute(preferredActionType action: ActionType, withFavoriteValueType type: TypesOfFavoriteValue, withValue value: String) {
        /*
         eMail, Phone, Text, Whatsapp, FaceTime, FaceTimeAudio, Web, Maps, Whatsapp
         Skype, Messenger, Twitter ... in the future
         */
        
        if canExecute(action: action, withFavoriteType: type) {
            
            var actionURLScheme = ""
            
            switch action {
            case .eMail:
                actionURLScheme = "mailto"
                executeStandard(actionURLScheme: actionURLScheme, forValue: value)
            case .Call:
                actionURLScheme = "tel"
                executeStandard(actionURLScheme: actionURLScheme, forValue: value.removeWhitespaces())
            case .Text:
                actionURLScheme = "sms"
                executeStandard(actionURLScheme: actionURLScheme, forValue: value)
            case .FaceTime:
                actionURLScheme = "facetime"
                executeStandard(actionURLScheme: actionURLScheme, forValue: value)
            case .FaceTimeAudio:
                actionURLScheme = "facetime-audio"
                executeStandard(actionURLScheme: actionURLScheme, forValue: value)
            case .Web:
                actionURLScheme = "http"
                executeStandard(actionURLScheme: actionURLScheme, forValue: value)
            case .Maps:
                actionURLScheme = "http"
                executeStandard(actionURLScheme: actionURLScheme, forValue: value)
            //http://maps.apple.com/?address=1,Infinite+Loop,Cupertino,California
            
            case .WhatsApp:
                // According to https://faq.whatsapp.com/en/general/26000030
                // Using Click to Chat:
                // To create your own link with a pre-filled message that will automatically appear in the text field of a chat, use https://api.whatsapp.com/send?phone=whatsappphonenumber&text=urlencodedtext where whatsappphonenumber is a full phone number in international format and urlencodedtext is the URL-encoded pre-filled message.
                // Example: https://api.whatsapp.com/send?phone=15551234567&text=I'm%20interested%20in%20your%20car%20for%20sale
                
                actionURLScheme = "https"
                var whatsappMessage = ""
                whatsappMessage = whatsappMessage.replace(characterSet: [(" ","%20"), (":","%3A"), ("/","%2F"), ("?","%3F"), (",","%2C"), ("=","%3D"), ("&","%26")])
                let whatsappPaidLoad = "api.whatsapp.com/send?phone=\(value.removeWhitespaces())&text=\(whatsappMessage)"
                executeStandard(actionURLScheme: actionURLScheme, forValue: whatsappPaidLoad)

//            default:
//                print("type action not available")
//                break
            }
        } else {
            print("Cannot execute action with this type of favorite value")
            return
        }
    }

    fileprivate class func executeStandard(actionURLScheme URLscheme: String, forValue value: String) {
        if let actionURL:NSURL = NSURL(string:"\(URLscheme)://\(value)") {
            
            let application:UIApplication = UIApplication.shared

            if (application.canOpenURL(actionURL as URL)) {
                application.open(actionURL as URL, options: [:]) { success in
                    print("Open \(URLscheme) openned = \(success) ")
                    
                    // TODO: Register here the action in the recents database
                }
            }
        }
    }
}

