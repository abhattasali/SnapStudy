//
//  NextViewController.swift
//  DrawFeature
//
//  Created by Arun Bhattasali on 7/30/19.
//  Copyright © 2019 Ryan Chang. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {


    @IBOutlet weak var myDisplayImage: UIImageView!
    var myImage : UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print("hello")
        
    }
    
    
    @IBAction func didUnwindFromVC(_ sender: UIStoryboardSegue)
    {
        guard let vc = sender.source as? ViewController else { return }
        self.myImage = vc.testImage
        myDisplayImage.image = myImage
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
