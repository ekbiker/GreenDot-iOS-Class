//
//  LoginVC.swift
//  GD Lunch
//
//  Created by Ted Liao on 5/8/17.
//  Copyright © 2017 Ted Liao. All rights reserved.
//

import UIKit

class LoginVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Login"
        view.backgroundColor = Style.Color.darkMustard
    }

    @IBAction func sendTapped(_ sender: BaseButton) {
        print("sendTapped")
    }

}

extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
}
