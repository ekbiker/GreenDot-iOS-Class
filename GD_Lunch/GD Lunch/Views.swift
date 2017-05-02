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
