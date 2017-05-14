//
//  BaseVC.swift
//  GD Lunch
//
//  Created by Ted Liao on 4/16/17.
//  Copyright © 2017 Ted Liao. All rights reserved.
//

import UIKit

//MARK: - easy to use initializers and presentation with a nav
extension UIViewController {
    
    convenience init(nibNameInferredForBundle bundle: Bundle?) {
        let vcType = type(of: self) //run-time type (type of whatever subclass) as a value
        let nibName = String(describing: vcType)
        self.init(nibName: nibName, bundle: bundle)
    }
    
    func presentWithNavigation(_ vc: UIViewController,
                               animated: Bool,
                               configuration: ((UINavigationController)->Void)? = nil,
                               completion: (()->Void)? ) {
        let nc = UINavigationController(rootViewController: vc)
        configuration?(nc)
        present(nc, animated: animated, completion: completion)
    }
}

//MARK: - child vc management convenience methods
extension UIViewController {
    
    func showChild(vc: UIViewController, inView view: UIView? = nil, withFrame rect: CGRect? = nil) {
        addChildViewController(vc)
        
        //assign frame size
        if let viewRect = rect {
            vc.view.frame = viewRect
        }
        else if let inView = view {
            vc.view.frame = inView.bounds
        }
        else {
            vc.view.frame = self.view.bounds
        }
        
        //add as subview
        if let inView = view {
            inView.addSubview(vc.view)
        }
        else {
            self.view.addSubview(vc.view)
        }
        
        vc.didMove(toParentViewController: self)
    }
    
    func hideChild(vc: UIViewController) {
        vc.willMove(toParentViewController: nil)
        vc.view.removeFromSuperview()
        vc.removeFromParentViewController()
    }
    
    func hideChildren() {
        for vc in childViewControllers {
            hideChild(vc: vc)
        }
    }
}


class BaseVC: UIViewController {

    //thse callback blocks gets run only once and we can set them before the view is presented or during viewDidLoad
    var onViewDidAppear: (()->Void)? = nil
    var onViewWillAppear: (()->Void)? = nil
    var onViewWillLayoutSubviews: (()->Void)? = nil
    var onViewDidLayoutSubviews: (()->Void)? = nil
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        //viewDidAppear is not called when a controller is added as a child to a parent manually
        super.viewDidAppear(animated)
        onViewDidAppear?()
        onViewDidAppear = nil
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        //viewWillAppear is not called when a controller is added as a child to a parent manually
        super.viewWillAppear(animated)
        onViewWillAppear?()
        onViewWillAppear = nil
    }
    
    override public func viewWillLayoutSubviews() {
        //called everytime layout constraints change, i.e. when we have to set constraints at run-time
        super.viewWillLayoutSubviews()
        onViewWillLayoutSubviews?()
        onViewWillLayoutSubviews = nil
    }
    
    override public func viewDidLayoutSubviews() {
        //called everytime layout constraints change, i.e. when we have to set constraints at run-time
        super.viewDidLayoutSubviews()
        onViewDidLayoutSubviews?()
        onViewDidLayoutSubviews = nil
    }
    
    //add other rotational callbacks as needed...

}
