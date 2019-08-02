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
    @IBOutlet weak var smallView: UIView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        startAnimation()
        
    }
    
    var wt_flashset: FlashSet!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cardWrapperVC = segue.destination as? UICardWrapper else { return }
        cardWrapperVC.flashset = wt_flashset
    }
    
    func startAnimation() {
        
        animationView.frame = smallView.bounds
        animationView.contentMode = .scaleAspectFit
        self.smallView.addSubview(animationView)
        animationView.play { (finished) in
    
            self.performSegue(withIdentifier: "testSegue", sender: nil)
        }
        
    }

}
