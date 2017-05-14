//
//  Buttons.swift
//  GD Lunch
//
//  Created by Ted Liao on 4/16/17.
//  Copyright © 2017 Ted Liao. All rights reserved.
//

import Foundation
import UIKit

public protocol BaseButtonImageHelpers {
    func test() -> Void
}

public protocol BaseButtonBackgroundHelpers {
    
}

public protocol BaseButtonTextHelpers {
    
}

//---------------------------------------------------
//MARK: - This is the base button for all our classes
//---------------------------------------------------
@IBDesignable
public class BaseButton: UIButton {
    
    @IBInspectable
    var textColor: UIColor = .white {
        didSet {
            setTitleColor(textColor, for: .normal)
            setTitleColor(textColor, for: .highlighted)
            setTitleColor(textColor, for: .selected)
        }
    }
    
    @IBInspectable
    var normalBkgColor: UIColor = .blue {
        didSet {
            let img = UIImage(color: normalBkgColor, size: CGSize(width: 1, height: 1))
            setBackgroundImage(img, for: .normal)
        }
    }
    
    @IBInspectable
    var highlightedBkgColor: UIColor = .black {
        didSet {
            let img = UIImage(color: highlightedBkgColor, size: CGSize(width: 1, height: 1))
            setBackgroundImage(img, for: .highlighted)
            setBackgroundImage(img, for: .selected)
        }
    }
    
    @IBInspectable
    var imageTintColor: UIColor = .darkGray {
        didSet{
            if let img = image(for: .normal) {
                setImage(img.imageByTintColor(imageTintColor), for: .normal)
            }
            if let img = image(for: .selected) {
                setImage(img.imageByTintColor(imageTintColor), for: .selected)
            }
            if let img = image(for: .highlighted) {
                setImage(img.imageByTintColor(imageTintColor), for: .highlighted)
            }
            if let img = image(for: .disabled) {
                setImage(img.imageByTintColor(imageTintColor), for: .disabled)
            }
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    open func setup() {
        //subclass can override
        clipsToBounds = true
        adjustsImageWhenHighlighted = false
        adjustsImageWhenDisabled = false
        
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        addTarget(self, action: #selector(touchUpOutside), for: .touchUpOutside)
    }
    
    @objc private func touchDown()      {setHighlight()}
    @objc private func touchUpOutside() {unsetHighlight()}
    @objc private func touchUpInside()  {unsetHighlight()}
    
    open func setHighlight() {
        //subclass can override
        isHighlighted = true
    }
    
    open func unsetHighlight() {
        //subclass can override
        isHighlighted = false
    }
}
