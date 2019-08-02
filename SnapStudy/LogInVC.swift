//
//  LogInVC.swift
//  SnapStudy
//
//  Created by Arun Bhattasali on 8/1/19.
//

import UIKit

class LogInVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {
   
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.username.delegate = self
        self.password.delegate = self
        self.whiteView.layer.cornerRadius = 15
        self.logInButton.layer.cornerRadius = 10
       // self.signup.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.view.endEditing(true)
        //signup.resignFirstResponder()
        return false
    }

}
