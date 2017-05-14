//
//  views.swift
//  GD Lunch
//
//  Created by Ted Liao on 4/16/17.
//  Copyright © 2017 Ted Liao. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public extension UIView {
    @IBInspectable
    public var cornerRadius: CGFloat {
        get{
            return layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    public var borderWidth: CGFloat {
        get{
            return layer.borderWidth
        }
        set{
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    public var borderColor: UIColor {
        get{
            guard let cgColor = layer.borderColor else {
                return UIColor.white
            }
            return UIColor(cgColor: cgColor)
        }
        set{
            layer.borderColor = newValue.cgColor
        }
    }
    
    //for dismisser view
    func findFirstResponder() -> UIResponder? {
        if isFirstResponder {
            return self
        }
        for subview in subviews {
            if let firstResponder = subview.findFirstResponder() {
                return firstResponder
            }
        }
        return nil
    }
}

@IBDesignable
class RoundedV: UIView {
   
}

@IBDesignable
class CircleV: RoundedV {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundCorners()
    }
    
    override var frame: CGRect {
        didSet {
            roundCorners()
        }
    }
    override var bounds: CGRect {
        didSet {
            roundCorners()
        }
    }
    
    private func roundCorners() {
        cornerRadius = bounds.size.width/2
    }
}

class DismisserV: UIView {
    
    var blockDismisser = false
    var onDismiss: (()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        backgroundColor = UIColor.clear
        
        // Add tap gesture recognizer to remove keyboard
        let tap = UITapGestureRecognizer(target:self, action:#selector(viewTapped))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }
    
    @objc fileprivate func viewTapped() {
        if !blockDismisser {
            window?.findFirstResponder()?.resignFirstResponder()
            onDismiss?()
        }
    }
}

