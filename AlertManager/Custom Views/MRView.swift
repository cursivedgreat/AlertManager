//
//  MRView.swift
//  ErrorHandler
//
//  Created by Avinash Kumar on 18/01/18.
//  Copyright © 2018 Avinash Kumar. All rights reserved.
//

import UIKit

@IBDesignable class MRView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            refreshCorners(cornerRadius)
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
    
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        didSet {
            refreshShadowColor(shadowColor)
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet {
            refreshOpacity(shadowOpacity)
        }
    }
    
    @IBInspectable var shadowOffSet: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            refreshShadowOffset(shadowOffSet)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        shareInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        shareInit()
    }
   
    override func prepareForInterfaceBuilder() {
        shareInit()
    }
    
    func shareInit() {
        refreshCorners(cornerRadius)
        refreshBorderWidth(borderWidth)
        refreshBorderColor(borderColor)
        refreshShadowColor(shadowColor)
        refreshOpacity(shadowOpacity)
        refreshShadowOffset(shadowOffSet)
    }
    
    func refreshCorners(_ value: CGFloat) {
        layer.cornerRadius = value
    }

    func refreshBorderWidth(_ value: CGFloat) {
        layer.borderWidth = value
    }
    
    func refreshShadowColor(_ value: UIColor)  {
        layer.masksToBounds = false
        layer.shadowColor = value.cgColor
    }
    
    func refreshOpacity(_ value: Float) {
        layer.masksToBounds = false
        layer.shadowOpacity = value
    }
    
    func refreshShadowOffset(_ value: CGSize) {
        layer.masksToBounds = false
        layer.shadowOffset = value
    }
    
    func refreshBorderColor(_ value: UIColor) {
        layer.borderColor = value.cgColor
    }
}
