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
let CLIENT_ERROR_CODE = 4
let SERVER_ERROR_CODE = 5

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
    
    @objc static func isResponseValid(forResponse urlResponse: URLResponse?, andData data: Data?) -> Bool {
        if let httpResponse = urlResponse as? HTTPURLResponse {
            if httpResponse.statusCode/100 == 2 {
                return true
            } else {
                var displayError = DisplayError()
                displayError.title = NSLocalizedString("Error", comment: "Error")
                displayError.message = NSLocalizedString("Something went wrong!", comment: "Something went wrong!")
                if httpResponse.statusCode == 401 {
                    displayError.errorType = .unauthorized
                    displayError.title = NSLocalizedString("You have been logged out.", comment: "You have been logged out.")
                } else if httpResponse.statusCode/100 == CLIENT_ERROR_CODE {
                    displayError.title = NSLocalizedString("Client Error", comment: "Client Error")
                } else if httpResponse.statusCode/100 == SERVER_ERROR_CODE {
                    displayError.title = NSLocalizedString("Server Error", comment: "Server Error")
                }
                if let tData = data {
                    do {
                        let tError = try JSONDecoder().decode(SuppliedError.self, from: tData)
                        if let anError = tError.errors {
                            displayError.message = anError.debugDescription
                        }
                        ErrorDisplayController.displayError(displayError)
                    } catch {
                        ErrorDisplayController.displayError(displayError)
                        print("showError:fromData:: Couldn't parse data \(error)")
                    }
                } else {
                    ErrorDisplayController.displayError(displayError)
                }
                return false
            }
        }
        return false
    }
    
}
