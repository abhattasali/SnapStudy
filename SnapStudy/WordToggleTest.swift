//
//  WordToggleTest.swift
//  SnapStudy
//
//  Created by Arun Bhattasali on 7/22/19.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import UIKit
import MobileCoreServices
import TesseractOCR
import GPUImage
import Reductio
import Foundation

class WordToggleTest: UIViewController {

    var wt_flashset: FlashSet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("test \(wt_flashset.getSetName())")
        for w in wt_flashset.myWordCards.keys {
            print("\(w)")
            print("\((wt_flashset.myWordCards[w]?.definition)!)\n\n")
        }

        // Do any additional setup after loading the view.
    }
    

}
