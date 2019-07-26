//
//  UICardTest.swift
//  SnapStudy
//
//  Created by Arun Bhattasali on 7/26/19.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import UIKit

class UICardTest: UIViewController {
    
    var card_flashset: FlashSet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("test on uiCardVC: \(card_flashset.getSetName())")
        print()
        print()
        print()
        for w in card_flashset.myWordCards.keys {
            print("\(w)")
            print("\((card_flashset.myWordCards[w]?.definition)!)\n\n")
        }

      
    }
    

}
