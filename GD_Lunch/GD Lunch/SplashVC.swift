//
//  SplashVC.swift
//  GD Lunch
//
//  Created by Ted Liao on 4/16/17.
//  Copyright © 2017 Ted Liao. All rights reserved.
//

import UIKit

fileprivate let labelAnimationDuration = TimeInterval(1.0)

extension SplashVC { //UIContentContainer
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        //
    }
}

class SplashVC: BaseVC {

    @IBOutlet weak var forkAndKniefIV: UIImageView!
    
    @IBOutlet weak var gdFinalL: UILabel!
    @IBOutlet weak var lunchFinalL: UILabel!

    @IBOutlet weak var gdInitialL: UILabel!
    @IBOutlet weak var lunchInitialL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startAnimation(delay: 0.2, finished:nil)
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        //startAnimation(delay: 0.2)
//    }
    
    /*  Auto-layout Lecture Note: 
        animation basically set the frame, but auto layout does away with the idea of setting a frame.  But let the system do it.
        @IBDesignables,
        @IBInspectables
     
     */
    
    /*  1. Layout in simple naive way and demonstrate how it would run into trouble on smaller screens.
            a. view layer order
            b. view hierachy, coordinate system, difference between frame and bounds
            c. how are view positions defined.
            d.
        2. Demonstrate using auto-layout with layout containers
            a. edge constraints
            b. percentage constraints
            c. centering constraints
            d. aspect ratio
        3. Demonstrate animation with auto-layout
            a. define initial and final positions
        4. to ease debugging, let's wire up a tap gesture to repeat the animation.
            a. demostrate double tap protection
            b.
        4. move one text label, coordinate conversion (from one frame of reference to another), 
            a. difference between frame and bounds.
        5. move both text labels, factor out the animation method
        6. move the logo down
        7. move the logo using dynamic animatore
        8. demostrate keeping related code together using closures.   context - add/remove set/unset
     */
    
    private func moveTextLabel(initialLabel: UILabel, finalLabel: UILabel) {
        //demostrate guard let
        if let snapshotV = initialLabel.snapshotView(afterScreenUpdates: false) {
            snapshotV.frame = initialLabel.superview!.convert(initialLabel.frame, to: self.view)
            self.view.addSubview(snapshotV)
            initialLabel.isHidden = true
            
            UIView.animate(withDuration: labelAnimationDuration, animations: {
                let finalRect = finalLabel.superview!.convert(finalLabel.frame, to: self.view)
                snapshotV.frame = finalRect
                
            }, completion: {complete in
                finalLabel.isHidden = false
                snapshotV.removeFromSuperview()
            })
        }
        
        
//        typealias Point = (Int, Int)
//        let origin: Point = Point(0, 0)
//        let point = Point(0,0)
//        //In the second case, a type identifier uses dot (.) syntax to refer to named types declared in other modules or nested within other types. For example, the type identifier in the following code references the named type MyType that is declared in the ExampleModule module.
//        
//        typealias SplashAlias = GD_Lunch.SplashVC
//        var someValue = SplashAlias()
//        //GRAMMAR OF A TYPE IDENTIFIER
//        
//        let layer = Swift.type(of: forkAndKniefIV)
        
    }
    
    private func startAnimation(delay: TimeInterval, finished: (()->Void)?) {
        NSLog("startAnimation")
        gdInitialL.isHidden = false
        lunchInitialL.isHidden = false
        gdFinalL.isHidden = true
        lunchFinalL.isHidden = true
        forkAndKniefIV.isHidden = true
        
        
        Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { timer in
            self.moveTextLabel(initialLabel: self.gdInitialL, finalLabel: self.gdFinalL)
            self.moveTextLabel(initialLabel: self.lunchInitialL, finalLabel: self.lunchFinalL)
            
            Timer.scheduledTimer(withTimeInterval: labelAnimationDuration, repeats: false, block: {timer in
                let iv = UIImageView(image: UIImage(named: "forkandknief"))
                iv.frame = self.forkAndKniefIV.frame
                iv.center = CGPoint(x: iv.center.x, y: -100)
                self.forkAndKniefIV.superview!.addSubview(iv)
                
                self.dropForkAndKniefImageView(iv, referenceView: self.forkAndKniefIV.superview!) {
                    finished?()
                    iv.removeFromSuperview()
                    self.forkAndKniefIV.isHidden = false
                }
                
                //demo UIView.animate first, then use a dynamic animator
//                UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut, .layoutSubviews], animations: {
//                    iv.center = CGPoint(x: iv.center.x, y: initialCenterY)
//                    
//                }) { (complete) in
//                    self.forkAndKniefIV.isHidden = false
//                    iv.removeFromSuperview()
//                }
            })
        }
    }
    
    //Lecture Note: animation basically set the frame, but auto layout does away with the idea of setting a frame.
    private var dropDownAnim: DynamicAnimatorDropFromTop?
    private func dropForkAndKniefImageView(_ iv: UIImageView, referenceView: UIView, finished:(()->Void)?) {
        let endingY = referenceView.bounds.height - (referenceView.bounds.height - iv.bounds.height)/2
        dropDownAnim = DynamicAnimatorDropFromTop(
            referenceView: referenceView,
            items: [iv],
            pt1: CGPoint(x: 0, y: endingY),
            pt2: CGPoint(x: referenceView.bounds.width, y: endingY),
            finished: { [unowned self] (animator) in
                self.dropDownAnim = nil //we no longer need it
                finished?()
        })
    }

    @IBAction func repeatAnimationTapped(_ sender: UITapGestureRecognizer) {
        forkAndKniefIV.superview?.isUserInteractionEnabled = false
        startAnimation(delay: 0) {
            self.forkAndKniefIV.superview?.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func loginTapped(_ sender: BaseButton) {
    }
    
    @IBAction func newTapped(_ sender: BaseButton) {
    }
}
