//
//  Buttons.swift
//  GD Lunch
//
//  Created by Ted Liao on 4/16/17.
//  Copyright © 2017 Ted Liao. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
    
    public convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContext(size)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        if let context = UIGraphicsGetCurrentContext(), let cgimg = context.makeImage() {
            self.init(cgImage: cgimg)
        }
        else {
            self.init() //empty image
        }
        UIGraphicsEndImageContext()
    }
    
    /* handy utils to tint image and add transparent padding around it */
    public func imageByTintColor(_ color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        //transform the current context
        if let context = UIGraphicsGetCurrentContext(), let cgImage = self.cgImage {
            context.translateBy(x: 0, y: self.size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            context.setBlendMode(CGBlendMode.normal)
            
            //draw the new image
            let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
            context.clip(to: rect, mask: cgImage) //this does the trick
            color.setFill()
            context.fill(rect)
            
            //get the image out
            if let image = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                return image
            }
        }
        UIGraphicsEndImageContext()
        return self
    }
    
    public func imageByAddingPaddingTop(_ top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> UIImage {
        let width:CGFloat = self.size.width+left+right
        let height:CGFloat = self.size.height+top+bottom
        
        //current context
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, self.scale)
        if let context = UIGraphicsGetCurrentContext() {
            UIGraphicsPushContext(context)
            //draw the new image
            let origin:CGPoint = CGPoint(x: left, y: top)
            self.draw(at: origin)
            
            //get the image out
            UIGraphicsPopContext()
            if let image = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                return image
            }
        }
        UIGraphicsEndImageContext()
        return self
    }
    
    public func imageBySubtractingImage(_ maskImage: UIImage) -> UIImage {
        //I believe you can accomplish this by using the kCGBlendModeDestinationOut blend mode.
        // Create a new context, draw your background image, then draw the foreground image with this blend mode.
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(at: CGPoint.zero)
        maskImage.draw(at: CGPoint.zero, blendMode:.destinationOut, alpha:1.0)
        
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return image
        }
        UIGraphicsEndImageContext()
        return self
    }
    
    public func imageBySize(_ size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return image
        }
        UIGraphicsEndImageContext()
        return self
    }
    
    public func imageByExtractingRect(_ rect: CGRect) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, self.scale)
        self.draw(at: CGPoint(x: -rect.origin.x, y: -rect.origin.y))
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        UIGraphicsEndImageContext()
        return self
    }
}


//---------------------------------------------------
//MARK: - This is the base button for all our classes
//---------------------------------------------------
@IBDesignable
public class BaseButton: UIButton {
    
//    @IBInspectable
//    public var borderWidth: CGFloat {
//        didSet{
//            layer.borderWidth = borderWidth
//        }
//    }
//    
//    @IBInspectable
//    public var borderColor: UIColor {
//        didSet{
//            layer.borderColor = borderColor.cgColor
//        }
//    }
    
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

public protocol BaseButtonImageHelpers {
//    var testProp: String
    
    func test() -> Void
}

public protocol BaseButtonBackgroundHelpers {
    
}

public protocol BaseButtonTextHelpers {

    
}

//------------------------------------------
//MARK: - Underlined, looks like a hyperlink
//------------------------------------------
//@IBDesignable
//class PR_UnderlineB: BaseButton {
//    
//    //replace super's implementation of normalColor and highlightColor
//    private var _normalBkgColor: UIColor = .cpMediumPurple
//    override var normalBkgColor: UIColor {
//        set{_normalBkgColor = newValue}
//        get{return _normalBkgColor}
//    }
//    private var _highlightedBkgColor: UIColor = .cpDarkPurple
//    override var highlightedBkgColor: UIColor {
//        set{_highlightedBkgColor = newValue}
//        get{return _highlightedBkgColor}
//    }
//    
//    @IBInspectable
//    var lineWidth: CGFloat = 1.0
//    
//    @IBInspectable
//    var showUnderline: Bool = false {
//        didSet {
//            showUnderline ? showUnderline(lineWidth) : hideUnderline()
//        }
//    }
//    
//    fileprivate var _underlineV: UIView?
//    fileprivate var underlineV: UIView {
//        get {
//            if _underlineV == nil {
//                _underlineV = UIView(frame: CGRect(x: 3.0, y: bounds.size.height-1, width: bounds.size.width-6.0, height: 1))
//                _underlineV!.autoresizingMask = .flexibleWidth
//                addSubview(_underlineV!)
//            }
//            return _underlineV!
//        }
//    }
//    
//    override func setup() {
//        super.setup()
//        textColor = normalColor //starting color
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        if showUnderline {
//            showUnderline(lineWidth)
//        }
//    }
//    
//    override func setHighlight() {
//        //don't call super
//        underlineV.backgroundColor = highlightColor
//        textColor = highlightColor
//    }
//    
//    override func unsetHighlight() {
//        //don't call super
//        underlineV.backgroundColor = normalColor
//        textColor = normalColor
//    }
//    
//    fileprivate func showUnderline(_ lineH: CGFloat) {
//        if let label: UILabel = titleLabel, let text = label.text {
//            
//            let size = (text as NSString).size(attributes: [NSFontAttributeName: label.font]) //text size with current font
//            let textW = size.width
//            let textH = size.height
//            
//            underlineV.bounds = CGRect(x: 0.0, y: 0.0, width: textW, height: lineH)
//            underlineV.center = CGPoint(x: bounds.size.width/2, y: (bounds.size.height+textH+lineH)/2 - 1)
//            underlineV.backgroundColor = titleColor(for: .normal)
//            underlineV.isHidden = false
//        }
//    }
//    
//    fileprivate func hideUnderline() {
//        underlineV.isHidden = true
//    }
//}


//@IBDesignable
//class UIRoundedB: UIButton {
//    @IBInspectable var textColor: UIColor = .white {
//        didSet {
//            setTitleColor(textColor, for: .normal)
//            setTitleColor(textColor, for: .highlighted)
//            setTitleColor(textColor, for: .selected)
//        }
//    }
//    @IBInspectable var normalColor: UIColor = .blue {
//        didSet {
//            let img = UIImage(color: normalColor, size: CGSize(width: 1, height: 1))
//            setBackgroundImage(img, for: .normal)
//        }
//    }
//    @IBInspectable var highlightColor: UIColor = .black {
//        didSet {
//            let img = UIImage(color: highlightColor, size: CGSize(width: 1, height: 1))
//            setBackgroundImage(img, for: .highlighted)
//            setBackgroundImage(img, for: .selected)
//        }
//    }
//    @IBInspectable var imageTintColor: UIColor = .darkGray {
//        didSet{
//            if let img = image(for: .normal) {
//                setImage(img.imageByTintColor(imageTintColor), for: .normal)
//            }
//            if let img = image(for: .selected) {
//                setImage(img.imageByTintColor(imageTintColor), for: .selected)
//            }
//            if let img = image(for: .highlighted) {
//                setImage(img.imageByTintColor(imageTintColor), for: .highlighted)
//            }
//            if let img = image(for: .disabled) {
//                setImage(img.imageByTintColor(imageTintColor), for: .disabled)
//            }
//            if let img = backgroundImage(for: .normal) {
//                setBackgroundImage(img.imageByTintColor(imageTintColor), for: .normal)
//            }
//            if let img = backgroundImage(for: .selected) {
//                setBackgroundImage(img.imageByTintColor(imageTintColor), for: .selected)
//            }
//            if let img = backgroundImage(for: .highlighted) {
//                setBackgroundImage(img.imageByTintColor(imageTintColor), for: .highlighted)
//            }
//            if let img = backgroundImage(for: .disabled) {
//                setBackgroundImage(img.imageByTintColor(imageTintColor), for: .disabled)
//            }
//        }
//    }
//    @IBInspectable var borderWidth: CGFloat = 0.0 {
//        didSet{
//            layer.borderWidth = borderWidth
//        }
//    }
//    @IBInspectable var borderColor: UIColor = .clear {
//        didSet{
//            layer.borderColor = borderColor.cgColor
//        }
//    }
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        setup()
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        //fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setup() {
//        //subclass can override
//        clipsToBounds = true
//        adjustsImageWhenHighlighted = false
//        adjustsImageWhenDisabled = false
//        
//        //tTODO: if this doesn't do the trick we can try override touchesBegin
//        addTarget(self, action: #selector(touchDown), for: .touchDown)
//        addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
//        addTarget(self, action: #selector(touchUpOutside), for: .touchUpOutside)
//    }
//    
//    @objc fileprivate func touchDown()      {setHighlight()}
//    @objc fileprivate func touchUpOutside() {unsetHighlight()}
//    @objc fileprivate func touchUpInside()  {
//        //tTODO: may not want to do this as subclasses may have already have some sort of mechanism in place
//        //double tapp prevention
//        //userInteractionEnabled = false
//        //NSTimer.scheduledTimerWithTimeInterval(0.2, repeats: false) { tm in
//        self.unsetHighlight()
//        //self.userInteractionEnabled = true
//        //}
//    }
//    
//    func setHighlight() {
//        //subclass can override
//        isHighlighted = true
//    }
//    
//    func unsetHighlight() {
//        //subclass can override
//        isHighlighted = false
//    }
//}

////-------------------
////MARK: -
////-------------------
//class UISpinnerB: UIRoundedB {
//    
//    fileprivate var spinner: UIActivityIndicatorView!
//    fileprivate var shadeV: UIView!
//    
//    override init(frame: CGRect) {
//        super.init(frame:frame)
//        setup()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        //fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        setup()
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if spinner.isHidden {
//            super.touchesBegan(touches, with: event)
//        }
//    }
//    
//    override func setup() {
//        super.setup()
//        spinner = UIActivityIndicatorView(frame: bounds)
//        spinner.hidesWhenStopped = true
//        spinner.activityIndicatorViewStyle = .whiteLarge
//        spinner.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin]
//        spinner.isHidden = true
//        addSubview(spinner)
//        
//        shadeV = UIView(frame: bounds)
//        shadeV.backgroundColor = UIColor(white: 0.0, alpha: 0.15)
//        shadeV.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        shadeV.isHidden = true
//        insertSubview(shadeV, belowSubview: spinner)
//    }
//    
//    func showSpinner() {
//        //spin always shows
//        spinner.startAnimating()
//        spinner.isHidden = false
//        shadeV.isHidden = false
//    }
//    
//    func hideSpinner() {
//        //stop always hides
//        spinner.stopAnimating()
//        spinner.isHidden = true
//        shadeV.isHidden = true
//    }
//}
//
//@IBDesignable
//class PR_SplashBigB: UIRoundedB {
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        
//        //titleEdgeInsets = UIEdgeInsetsMake(0, 0, 2, 0)
//        normalColor = .cpMediumPurple
//        highlightColor = .cpDarkPurple
//        textColor = .white
//    }
//}
//
////---------------------------
////MARK: - used in entry forms
////---------------------------
//@IBDesignable
//class PR_EntryBigB: UIRoundedB {
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        
//        //titleEdgeInsets = UIEdgeInsetsMake(0, 0, 2, 0)
//        normalColor = .cpOrange
//        highlightColor = .cpOrangeHighlight
//        textColor = .white
//    }
//}
//
////-------------------------------------
////MARK: - used in adding items to lists
////-------------------------------------
//class PR_AddItemB: UIRoundedB {
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        
//        backgroundColor = .white
//        imageTintColor = .cpOrange
//        setTitleColor(.cpDarkerGray, for: .normal)
//        
//        normalColor = .cpVeryLightGray
//        highlightColor = .cpLighterGray
//    }
//}
//
////------------------------------------------
////MARK: - Underlined, looks like a hyperlink
////------------------------------------------
//@IBDesignable
//class PR_UnderlineB: UIRoundedB {
//    
//    //replace super's implementation of normalColor and highlightColor
//    fileprivate var _normalColor: UIColor = .cpMediumPurple
//    override var normalColor: UIColor {
//        set{_normalColor = newValue}
//        get{return _normalColor}
//    }
//    fileprivate var _highlightColor: UIColor = .cpDarkPurple
//    override var highlightColor: UIColor {
//        set{_highlightColor = newValue}
//        get{return _highlightColor}
//    }
//    
//    @IBInspectable
//    var lineWidth: CGFloat = 1.0
//    
//    @IBInspectable
//    var showUnderline: Bool = false {
//        didSet {
//            showUnderline ? showUnderline(lineWidth) : hideUnderline()
//        }
//    }
//    
//    fileprivate var _underlineV: UIView?
//    fileprivate var underlineV: UIView {
//        get {
//            if _underlineV == nil {
//                _underlineV = UIView(frame: CGRect(x: 3.0, y: bounds.size.height-1, width: bounds.size.width-6.0, height: 1))
//                _underlineV!.autoresizingMask = .flexibleWidth
//                addSubview(_underlineV!)
//            }
//            return _underlineV!
//        }
//    }
//    
//    override func setup() {
//        super.setup()
//        textColor = normalColor //starting color
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        if showUnderline {
//            showUnderline(lineWidth)
//        }
//    }
//    
//    override func setHighlight() {
//        //don't call super
//        underlineV.backgroundColor = highlightColor
//        textColor = highlightColor
//    }
//    
//    override func unsetHighlight() {
//        //don't call super
//        underlineV.backgroundColor = normalColor
//        textColor = normalColor
//    }
//    
//    fileprivate func showUnderline(_ lineH: CGFloat) {
//        if let label: UILabel = titleLabel, let text = label.text {
//            
//            let size = (text as NSString).size(attributes: [NSFontAttributeName: label.font]) //text size with current font
//            let textW = size.width
//            let textH = size.height
//            
//            underlineV.bounds = CGRect(x: 0.0, y: 0.0, width: textW, height: lineH)
//            underlineV.center = CGPoint(x: bounds.size.width/2, y: (bounds.size.height+textH+lineH)/2 - 1)
//            underlineV.backgroundColor = titleColor(for: .normal)
//            underlineV.isHidden = false
//        }
//    }
//    
//    fileprivate func hideUnderline() {
//        underlineV.isHidden = true
//    }
//}
//
////-------------------
////MARK: -
////-------------------
//class PR_BackChevronWhiteB: UIRoundedB {
//    override func setup() {
//        super.setup()
//        
//        let white = UIImage(named: "nav_chevron_left_white")
//        setImage(white, for: .normal)
//        setImage(white, for: .selected)
//        setImage(white, for: .highlighted)
//    }
//}
//
////-------------------
////MARK: -
////-------------------
//class PR_BackChevronOrangeB: PR_BackChevronWhiteB {
//    override func setup() {
//        super.setup()
//        
//        if let img = image(for:.normal) {
//            let normal = img.imageByTintColor(.cpOrange)
//            setImage(normal, for: .normal)
//            let highlight = img.imageByTintColor(.cpOrangeHighlight)
//            setImage(highlight, for: .selected)
//            setImage(highlight, for: .highlighted)
//        }
//    }
//}
//
////-------------------
////MARK: -
////-------------------
//class PR_BackChevronMediumPurpleB: PR_BackChevronWhiteB {
//    override func setup() {
//        super.setup()
//        
//        if let img = image(for:.normal) {
//            let normal = img.imageByTintColor(.cpMediumPurple)
//            setImage(normal, for: .normal)
//            let highlight = img.imageByTintColor(.cpDarkPurple)
//            setImage(highlight, for: .selected)
//            setImage(highlight, for: .highlighted)
//        }
//    }
//}
//
////-------------------
////MARK: -
////-------------------
//class PR_CheckboxB: UIRoundedB {
//    //private var errorV: UIView!
//    fileprivate var errorImage: UIImage?
//    fileprivate var normalImage: UIImage?
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        //let spacing: CGFloat = 4.0
//        //errorV = UIView(frame: CGRectMake(spacing, spacing, bounds.size.width-spacing*2, bounds.size.height-spacing*2))
//        //errorV.layer.borderColor = UIColor.cpMediumOrange.cgColor
//        //errorV.layer.cornerRadius = 6.0
//        //errorV.layer.borderWidth = 2.0
//        //errorV.userInteractionEnabled = false
//        //addSubview(errorV)
//        normalImage = self.image(for: .normal)
//        if let img = normalImage {
//            errorImage = img.imageByTintColor(.cpDarkOrange)
//        }
//        resetErrorCondition()
//    }
//    
//    func showErrorCondition() {
//        //errorV.hidden = false
//        if let img = errorImage {
//            self.setImage(img, for: .normal)
//        }
//    }
//    
//    func resetErrorCondition() {
//        //errorV.hidden = true
//        if let img = normalImage {
//            self.setImage(img, for: .normal)
//        }
//    }
//}
//
////--------------------
////MARK: - for nav bars
////--------------------
//class PR_CloseXB: UIRoundedB {
//    override func setup() {
//        super.setup()
//        let image = UIImage(named: "nav_close_x_white")
//        setImage(image, for: .normal)
//        setImage(image, for: .highlighted)
//        imageEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12)
//        backgroundColor = .clear
//    }
//}
//
////---------------------
////MARK: - close Buttons
////---------------------
//class PR_CloseXWhiteB: UIRoundedB {
//    override func setup() {
//        super.setup()
//        let image = UIImage(named: "nav_close_x_white")
//        setImage(image, for: .normal)
//        let selected = UIImage(named: "nav_close_x_white")?.imageByTintColor(.cpMediumGray)
//        setImage(selected, for: .selected)
//        setImage(selected, for: .highlighted)
//        backgroundColor = .clear
//    }
//}
//
//class PR_CloseXOrangeB: UIRoundedB {
//    override func setup() {
//        super.setup()
//        let image = UIImage(named: "nav_close_x_white")?.imageByTintColor(.cpOrange)
//        setImage(image, for: .normal)
//        let selected = UIImage(named: "nav_close_x_white")?.imageByTintColor(.cpOrangeHighlight)
//        setImage(selected, for: .selected)
//        setImage(selected, for: .highlighted)
//        backgroundColor = .clear
//    }
//}
//
//class PR_CloseXDarkGrayB: UIRoundedB {
//    override func setup() {
//        super.setup()
//        let image = UIImage(named: "nav_close_x_white")?.imageByTintColor(.cpDarkGray)
//        setImage(image, for: .normal)
//        let selected = UIImage(named: "nav_close_x_white")?.imageByTintColor(.cpDarkerGray)
//        setImage(selected, for: .selected)
//        setImage(selected, for: .highlighted)
//        backgroundColor = .clear
//    }
//}
//
////-------------------
////MARK: -
////-------------------
//class PR_UserLocationB: UIRoundedB {
//    override func setup() {
//        super.setup()
//        let image = UIImage(named: "icon_user_location")
//        setImage(image, for: .normal)
//        setImage(image, for: .highlighted)
//        imageEdgeInsets = UIEdgeInsetsMake(10, 9, 10, 11)
//        backgroundColor = .clear
//    }
//}
//
//class PR_MapInfoB: UIRoundedB {
//    override func setup() {
//        super.setup()
//        let image = UIImage(named: "icon_info_white")
//        setImage(image, for: .normal)
//        setImage(image, for: .highlighted)
//        imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
//        backgroundColor = .clear
//    }
//}
//
////-------------------
////MARK: -
////-------------------
//class PR_ExpandScreenB: UIRoundedB {
//    override func setup() {
//        super.setup()
//        let image = UIImage(named: "icon_expand_screen")
//        setImage(image, for: .normal)
//        setImage(image, for: .highlighted)
//        imageEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12)
//        backgroundColor = .clear
//    }
//}
