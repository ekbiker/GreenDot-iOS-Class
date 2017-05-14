//
//  TextFields.swift
//  GD Lunch
//
//  Created by Ted Liao on 5/9/17.
//  Copyright © 2017 Ted Liao. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundedTF: UITextField {
    
    let sidePadding = CGFloat(10.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    open func setup() {
        self.layer.borderWidth = 2.0;
        self.textColor = UIColor.darkGray
    }
    
    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: sidePadding, dy: 0);
    }
    
    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        //add other rightViewMode and leftViewMode conditions when necessary
        //tNOTE: probably should call clearButtonRectForBounds to get clear button spacing
        
        if clearButtonMode == .whileEditing || clearButtonMode == .always {
            return CGRect(x: sidePadding, y: 0, width: bounds.size.width-sidePadding-30, height: bounds.size.height)
        }
        else {
            return bounds.insetBy(dx: sidePadding, dy: 0);
        }
    }
}

