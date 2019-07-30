//
//  CardPartPagedViewCardController.swift
//  CardParts_Example
//
//  Created by Roossin, Chase on 5/23/18.
//  Copyright © 2018 Intuit. All rights reserved.
//

import Foundation
import CardParts
import RxSwift
import RxCocoa

class CardPartPagedViewCardController: CardPartsViewController {
    
    let cardPartTextView = CardPartTextView(type: .normal)
    //let emojis: [String] = ["😎", "🤪", "🤩"]
    
    
    var key : String = ""
    var definition : String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardPartTextView.text = "SnapStudy™"
        cardPartTextView.textAlignment = .right
        cardPartTextView.textColor = UIColor.white
        //cardPartTextView.textColor = UIColor(red: 229.0/255.0, green: 187.0/255.0, blue: 72.0/255.0, alpha: 1.0)
        
        var stackViews: [CardPartStackView] = []    //1st Frame is a Keyword, Second Frame is a Definitino
        
       /* let sv = CardPartStackView()
        sv.axis = .vertical
        sv.spacing = 8
        */
        
        
        
        for _ in 0...1 {   //number of keywords
            
            let sv = CardPartStackView()
            sv.axis = .vertical
            sv.spacing = 2
            stackViews.append(sv)
            
          //  let titlePart = CardPartTitleView(type: .titleOnly)
           // titlePart.title = key
            //TEXT
            let titleP = CardPartLabel()
            titleP.text = key
            titleP.textAlignment = .center
            //FONT
            var descriptor = UIFontDescriptor(name: "Roboto", size: 24.0)
            descriptor = descriptor.addingAttributes([UIFontDescriptor.AttributeName.traits : [UIFontDescriptor.TraitKey.weight : UIFont.Weight.light]])
            titleP.font = UIFont(descriptor: descriptor, size: 24.0)
            
            sv.addArrangedSubview(titleP)
            
            let title = CardPartTextView(type: .normal)
            title.text = definition
            title.textAlignment = .center
            sv.addArrangedSubview(title)
            
            //let testPic = CardPartImageView(image: "")
        }
        
        let cardPartPagedView = CardPartPagedView(withPages: stackViews, andHeight: 250)
        setupCardParts([cardPartTextView, cardPartPagedView])
    }
}

extension CardPartPagedViewCardController: ShadowCardTrait {
    func shadowOffset() -> CGSize { return CGSize(width: 1.0, height: 1.0) }
    func shadowColor() -> CGColor { return UIColor.lightGray.cgColor }
    func shadowRadius() -> CGFloat{ return 6.0 }
    func shadowOpacity() -> Float { return 0.7 }
}

extension CardPartPagedViewCardController: RoundedCardTrait {
    func cornerRadius() -> CGFloat { return 10.0 }
}


extension CardPartPagedViewCardController: GradientCardTrait {
    func gradientColors() -> [UIColor] {
        let color1: UIColor = UIColor(red: 229.0 / 255.0, green: 187.0 / 255.0, blue: 72.0 / 255.0, alpha: 1.0)
        let color2: UIColor = UIColor(red: 220.0 / 255.0, green: 211.0 / 255.0, blue: 100.0 / 255.0, alpha: 1.0)
       return [color1, color2]
    }
    
    func gradientAngle() -> Float {
        return 0.0
    }
}

