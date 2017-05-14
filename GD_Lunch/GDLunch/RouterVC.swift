//
//  routerVC.swift
//  GD Lunch
//
//  Created by Ted Liao on 5/8/17.
//  Copyright © 2017 Ted Liao. All rights reserved.
//


import UIKit

class RouterVC: BaseVC {
    
    public var loggedin: Bool {
        get {return false}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if loggedin {
            let vc = MainFeedVC(nibNameInferredForBundle: nil)
            presentWithNavigation(vc, animated: false, completion: nil)
        }
        else {
            let vc = SplashVC(nibNameInferredForBundle: nil)
            presentWithNavigation(vc, animated: false, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

