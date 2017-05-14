//
//  SplashVC.swift
//  GD Lunch
//
//  Created by Ted Liao on 4/16/17.
//  Copyright © 2017 Ted Liao. All rights reserved.
//

import UIKit

fileprivate let labelAnimationDuration = TimeInterval(1.0)

//MARK: helpers to construct UI widgets
extension SplashVC { //UIContentContainer
    //this is fileprivate as opposed to private, making it private would have prevented the main implementation from seeing it.
    fileprivate func makeLoginButton() -> UIButton {
        let b = BaseButton(type: .custom)
        b.borderColor = .white
        b.borderWidth = 1.0
        b.cornerRadius = 5.0
        b.frame = CGRect(x: 0.0, y: 0.0, width: 55, height: 26.0)
        b.setTitle("Login", for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        return b
    }
}

//MARK: rotation Callbacks
extension SplashVC {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
    }
}

class SplashVC: BaseVC {

    @IBOutlet weak var forkAndKniefIV: UIImageView!
    
    @IBOutlet weak var gdFinalL: UILabel!
    @IBOutlet weak var lunchFinalL: UILabel!

    @IBOutlet weak var gdInitialL: UILabel!
    @IBOutlet weak var lunchInitialL: UILabel!
    
    //MARK: Lifecycle callbacks - appearance and layout
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Style.Color.darkMustard
        
        //make a login button with custom styling to insert into the Navigation bar
        let b = makeLoginButton()
        b.addTarget(self, action: #selector(loginTapped(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: b)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startAnimation(delay: 0.2, finished:nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    
    //MARK: animation helpers
    fileprivate func moveTextLabel(initialLabel: UILabel, finalLabel: UILabel) {
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
    }
    
    fileprivate func startAnimation(delay: TimeInterval, finished: (()->Void)?) {
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
            })
        }
    }
    
    fileprivate var dropDownAnim: DynamicAnimatorDropFromTop?
    fileprivate func dropForkAndKniefImageView(_ iv: UIImageView, referenceView: UIView, finished:(()->Void)?) {
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

    @IBAction fileprivate func repeatAnimationTapped(_ sender: UITapGestureRecognizer) {
        forkAndKniefIV.superview?.isUserInteractionEnabled = false
        startAnimation(delay: 0) {
            self.forkAndKniefIV.superview?.isUserInteractionEnabled = true
        }
    }
    
    
    //MARK: UI actions
    @objc fileprivate func loginTapped(_ sender: BaseButton) {
        let vc = LoginVC(nibNameInferredForBundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction fileprivate func newTapped(_ sender: BaseButton) {
        let vc = RegisterVC(nibNameInferredForBundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}
