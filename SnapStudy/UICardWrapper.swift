//
//  UICardWrapper.swift
//  SnapStudy
//
//  Created by Arun Bhattasali on 7/29/19.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import UIKit

class UICardWrapper: UIViewController {

    
    @IBOutlet weak var setName: UILabel!
    
    var flashset: FlashSet!
    override func viewDidLoad() {
        //print("test on UICardWrapper: \(flashset.getSetName())")
        if(flashset.setName != "")
        {
            setName.text = self.flashset.setName
        }
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let flashVC = segue.destination as? FlashDisplay else { return }
        flashVC.flashset = flashset
    }
    

}
