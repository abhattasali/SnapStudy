//
//  LogInVC.swift
//  SnapStudy
//
//  Created by Arun Bhattasali on 8/1/19.
//

import UIKit

class LogInVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.username.delegate = self
        self.password.delegate = self
       // self.signup.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.view.endEditing(true)
        //signup.resignFirstResponder()
        return false
    }

}
