//
//  UIImage.swift
//  GD Lunch
//
//  Created by Ted Liao on 5/14/17.
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
