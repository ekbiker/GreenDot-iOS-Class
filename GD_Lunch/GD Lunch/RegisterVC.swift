//
//  RegisterVC.swift
//  GD Lunch
//
//  Created by Ted Liao on 5/9/17.
//  Copyright © 2017 Ted Liao. All rights reserved.
//

import UIKit

class RegisterVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Join"
        view.backgroundColor = Style.Color.darkMustard
    }
    
    
    @IBAction func registerTapped(_ sender: BaseButton) {
        print("registerTapped")
    }

}

extension RegisterVC: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
}
