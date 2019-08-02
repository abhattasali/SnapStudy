//
//  LottieViewController.swift
//  testLottie
//
//  Created by Arun Bhattasali on 8/1/19.
//  Copyright © 2019 Arun Bhattasali. All rights reserved.
//

import UIKit
import Lottie

class LottieViewController: UIViewController {

    var animationView = AnimationView(name: "animation")
    @IBOutlet weak var smallFrame: UIView!
    var wt_flashset: FlashSet!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cardWrapperVC = segue.destination as? UICardWrapper else { return }
        cardWrapperVC.flashset = wt_flashset
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        startAnimation()
        
    }
    
    
    
    func startAnimation() {
        
        animationView.frame = smallFrame.bounds
        
        animationView.contentMode = .scaleAspectFit
        //animationView.currentTime(4.0)
        self.smallFrame.addSubview(animationView)
        
        animationView.play { (finished) in
            
            self.performSegue(withIdentifier: "testSegue", sender: nil)
        }
        
    }

}
