//
//  ErrorManager.swift
//  MOM
//
//  Created by Avinash Kumar on 19/01/18.
//  Copyright © 2018 MetaRain. All rights reserved.
//

import Foundation
import UIKit

struct Status: Codable {
    let message: String
    let code : Int
}

struct StatusObject: Codable {
    let status : Status
}

let VALID_RESPONSE_CODE = 2

@objc class ErrorManager: NSObject {
     static func showError(withTitle title: String?, message aMessage: String?, isCompulsory compulsory: Bool? = false) {
        var displayError = DisplayError()
        displayError.errorType = compulsory == true ? .always : .discardable
        if let tTitle = title {
            displayError.title = tTitle
        }
        if let tMessage = aMessage {
            displayError.message = tMessage
        }
        ErrorDisplayController.displayError(displayError)
    }
    
    @objc static func displayMessage(withTitle aTitle: String?, message aMessage: String?, isCompulsory compulsory: Bool) {
        ErrorManager.showError(withTitle: aTitle, message: aMessage, isCompulsory: compulsory)
    }
    
    static func isResponseValidFor(statusObject status: Status) -> Bool {
        var displayError = DisplayError()
        displayError.title = NSLocalizedString("Something went wrong. Please try again later.", comment: "Something went wrong. Please try again later.")
        if status.code/100 == VALID_RESPONSE_CODE {
            return true
        } else if status.code == 401 {
            displayError.errorType = .unauthorized
            displayError.title = NSLocalizedString("You have been logged out.", comment: "You have been logged out.")
        }
        ErrorDisplayController.displayError(displayError)
        return false
    }
    
}
