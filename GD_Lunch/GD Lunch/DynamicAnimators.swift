//
//  DynamicAnimators.swift
//  GD Lunch
//
//  Created by Ted Liao on 4/18/17.
//  Copyright © 2017 Ted Liao. All rights reserved.
//

import Foundation
import UIKit

/* we can reuse these dynamic animators throught out the app */

class DynamicAnimatorDropFromTop: UIDynamicAnimator, UIDynamicAnimatorDelegate {
    
    fileprivate var finished: (DynamicAnimatorDropFromTop) -> Void = {(TLDynamicAnimatorDropFromTop) in}
    
    convenience init(referenceView: UIView, items: [UIDynamicItem], pt1: CGPoint, pt2: CGPoint,
                     finished:@escaping (DynamicAnimatorDropFromTop)->Void )
    {
        self.init(referenceView: referenceView)
        self.delegate = self
        
        //Gravity
        let gravity = UIGravityBehavior(items: items)
        gravity.gravityDirection = CGVector(dx: 0.0, dy: 10.0) //this affects how fast it falls
        
        //collision
        let collision = UICollisionBehavior(items: items)
        //add 1 pix because the view settles just above the boundary
        // seems like iOS 9 settles 2 px
        let settle = CGFloat(2.0)
        collision.addBoundary(withIdentifier: "dropBottomBoundary" as NSCopying, from:CGPoint(x: pt1.x, y: pt1.y+settle), to:CGPoint(x: pt2.x, y: pt2.y+settle))
        
        //base item behaviors
        let itemBehavior = UIDynamicItemBehavior(items: items)
        itemBehavior.elasticity = 0.38
        
        //itemBehaviour.action = ^{
        //    //optional block
        //};
        
        self.addBehavior(gravity)
        self.addBehavior(collision)
        self.addBehavior(itemBehavior)
        
        self.finished = finished
    }
    
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        self.removeAllBehaviors()
        self.finished(self)
    }
}
