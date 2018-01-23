//
//  ErrorDisplayController.swift
//  MOM
//
//  Created by Avinash Kumar on 19/01/18.
//  Copyright © 2018 MetaRain. All rights reserved.
//

import UIKit

enum DisplayErrorType {
    case always
    case discardable
    case unauthorized
}

///Handle multiple concurrent error
class ErrorDisplayController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    private var errorList = [DisplayError]()
    private var window: UIWindow?
    
    @IBOutlet weak var verticalSpaceConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        verticalSpaceConstraint.constant = 1.0/UIScreen.main.scale
    }
    
    static private let shared = ErrorDisplayController.sharedInstance()
    
    static private func sharedInstance() -> ErrorDisplayController {
        let sb = UIStoryboard(name: "ErrorDisplayController", bundle: nil)
        let errorHandler = sb.instantiateViewController(withIdentifier: "ErrorDisplayController") as! ErrorDisplayController
        return errorHandler
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    static func displayError(_ error: DisplayError){
        let tController = ErrorDisplayController.shared
        tController.errorList.append(error)
        tController.displayError()
        if error.errorType == .unauthorized {
            if let tAppDelegate = UIApplication.shared.delegate as? AppDelegate {
                tAppDelegate.logout()
            }
        } 
    }
    
    private func displayError() {
        //Display latest error
        if let latestError = errorList.last {
            if latestError.errorType == .unauthorized {
                errorList = [latestError]
            } else {
                updateErrorList()
            }
            
            if window?.isKeyWindow == false || window == nil {
                showAlert()
            }
            titleLabel.text = latestError.title
            messageLabel.text = latestError.message
        }
    }
    
    private func updateErrorList() {
        //Cache current error in display
        let lastError = errorList.removeLast()
        
        //Update list
        var updatedList = [DisplayError]()
        if errorList.count > 0 {
            for tDisplayError in errorList {
                if tDisplayError.errorType == .always {
                    updatedList.append(tDisplayError)
                }
            }
        }
        updatedList.append(lastError)
        errorList = updatedList
    }
    
    private func showAlert() {
        if window == nil {
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.windowLevel = UIWindowLevelNormal
        }
        window!.rootViewController = ErrorDisplayController.shared
        window?.makeKeyAndVisible()
    }
    
    @IBAction private func okButtonPressed(_ sender: RoundButton) {
        errorList.removeLast()
        if errorList.count == 0 {
            let mainWindow = UIApplication.shared.delegate?.window
            mainWindow??.makeKeyAndVisible()
        } else {
            displayError()
        }
    }
}

struct DisplayError {
    var title = ""
    var message = ""
    var errorType = DisplayErrorType.discardable
}
