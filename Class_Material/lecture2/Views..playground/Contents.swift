//: Playground - noun: a place where people can play

import UIKit
import CoreGraphics
import PlaygroundSupport

func getOutlineView(rect: CGRect) -> UIView {
    let outline = UIView(frame: rect)
    outline.backgroundColor = .clear
    outline.layer.borderColor = UIColor.red.cgColor
    outline.layer.borderWidth = 1
    return outline
}


let rootViewSize = CGSize(width: 300, height: 300)

let view = UIView(frame: CGRect(x: 0, y:0, width: 80, height:120))
view.backgroundColor = .blue
view.center = CGPoint(x: rootViewSize.width/2, y: rootViewSize.height/2)

let rootView = UIView(frame: CGRect(x: 0, y: 0, width: rootViewSize.width, height: rootViewSize.height))
rootView.addSubview(view)
print(view.frame)  //frame is expressed in the superview's coordinate system
print(view.bounds) //bounds is expressed in the view's own coordinate system


view.removeFromSuperview()
view.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/4))
rootView.addSubview(view)
rootView.addSubview(getOutlineView(rect: view.frame))
print(view.frame)  //red outline is now the frame rect after rotation
print(view.bounds) //bounds remain the same

PlaygroundPage.current.liveView = rootView
PlaygroundPage.current.needsIndefiniteExecution = true

