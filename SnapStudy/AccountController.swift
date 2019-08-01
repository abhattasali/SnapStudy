//
//  AccountController.swift
//  SnapStudy
//
//  Created by Arun Bhattasali on 7/31/19.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import UIKit
import Foundation

class AccountController: UIViewController
{
    
    @IBOutlet weak var dyslexieSwitch: UISwitch!
    @IBOutlet weak var shareSwitch: UISwitch!
    @IBOutlet weak var text1: UIButton!
    @IBOutlet weak var text2: UIButton!
    
    @IBOutlet weak var text3: UIButton!
    @IBOutlet weak var text4: UIButton!
    @IBOutlet weak var text5: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dyslexieSwitch.onTintColor = UIColor(red: 229.0 / 255.0, green: 187.0 / 255.0, blue: 72.0 / 255.0, alpha: 1.0)
        dyslexieSwitch.tintColor = UIColor(red: 229.0 / 255.0, green: 187.0 / 255.0, blue: 72.0 / 255.0, alpha: 1.0)
        
        shareSwitch.onTintColor = UIColor(red: 229.0 / 255.0, green: 187.0 / 255.0, blue: 72.0 / 255.0, alpha: 1.0)
        shareSwitch.tintColor = UIColor(red: 229.0 / 255.0, green: 187.0 / 255.0, blue: 72.0 / 255.0, alpha: 1.0)
        
    print("hello")
        
    }
    
    
    @IBAction func toggleDyslexie(_ sender: Any) {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        if(dyslexieSwitch.isOn)
        {
            print("ON")
            appDel.isDyslexieOn = true
            
            text5.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 30)
            
            //text5.titleLabel?.font = UIFont(name: "Roboto-Medium")?  //(name: "Roboto", size: 50)
            
         
            
            
            for family in UIFont.familyNames.sorted() {
                let names = UIFont.fontNames(forFamilyName: family)
                print("Family: \(family) Font names: \(names)")
            }
            
            //text5.titleLabel?.backgroundColor = .blue
           
        }
        else
        {
            print("OFF")
            appDel.isDyslexieOn = false
        }
    }
    
    
    
   

    


}
