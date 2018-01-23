//
//  RoundButton.swift
//  ErrorHandler
//
//  Created by Avinash Kumar on 18/01/18.
//  Copyright © 2018 Avinash Kumar. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable class RoundButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 4.0 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            refreshBorderWidth(borderWidth)
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            refreshBorderColor(borderColor)
        }
    }
    
    //For programmatically created Button
    override init(frame: CGRect) {
        super.init(frame: frame)
        shareInit()
    }
    
    //For Storyboard/.xib created Button
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        shareInit()
    }
    
    //For Storyboard editor created Button
    override func prepareForInterfaceBuilder() {
        shareInit()
    }
    
    func shareInit(){
        refreshCorners(value: cornerRadius)
    }
    
    func refreshCorners(value aValue:CGFloat) {
        layer.cornerRadius = aValue
    }
    
    func refreshBorderWidth(_ value: CGFloat) {
        layer.borderWidth = value
    }
    func refreshBorderColor(_ value: UIColor) {
        layer.borderColor = value.cgColor
    }
}
