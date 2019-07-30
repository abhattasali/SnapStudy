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
import AVFoundation

class CardPartPagedViewCardController: CardPartsViewController {
    
    let cardPartTextView = CardPartTextView(type: .normal)

    var key : String = ""
    var definition : String = ""
    var image : UIImage? = nil
    var isPlayingSound : Bool = false
    let synthesizer = AVSpeechSynthesizer()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardPartTextView.text = "SnapStudy™"
        cardPartTextView.textAlignment = .right
        cardPartTextView.textColor = UIColor.white
        //cardPartTextView.textColor = UIColor(red: 229.0/255.0, green: 187.0/255.0, blue: 72.0/255.0, alpha: 1.0)
        
        var stackViews: [CardPartStackView] = []    //1st Frame is a Keyword, Second Frame is a Definitino
        
        /*******FRAME 1: Keyword********/
        let sv1 = CardPartStackView()
        sv1.axis = .vertical
        sv1.spacing = 8
        stackViews.append(sv1)
        //let titlePart = CardPartTitleView(type: .titleOnly)
        let word = CardPartLabel()
        word.text = self.key
        word.textColor = .white
        word.textAlignment = .center
        var descriptor = UIFontDescriptor(name: "Roboto", size: 30.0)
        descriptor = descriptor.addingAttributes([UIFontDescriptor.AttributeName.traits : [UIFontDescriptor.TraitKey.weight: UIFont.Weight.light]])
        word.font = UIFont(descriptor: descriptor, size: 30.0)
        
        let audioKeyButton = CardPartButtonView()
        audioKeyButton.setTitle("Play Sound", for: .normal)
        audioKeyButton.addTarget(self, action: #selector(playKeySound), for: .touchUpInside)
        audioKeyButton.contentHorizontalAlignment = .center
        
        
        sv1.addArrangedSubview(word)
        sv1.addArrangedSubview(audioKeyButton)
        
        
        /*******FRAME 2: Keyword********/
        let sv2 = CardPartStackView()           //Definition Text
        sv2.axis = .vertical
        sv2.spacing = 8
        stackViews.append(sv2)
        let cardDef = CardPartTextView(type: .normal)
        cardDef.text = self.definition
        cardDef.textColor = .white
        var defDescriptor = UIFontDescriptor(name: "Roboto", size: 14.0)
        defDescriptor = defDescriptor.addingAttributes([UIFontDescriptor.AttributeName.traits : [UIFontDescriptor.TraitKey.weight : UIFont.Weight.light]])
        cardDef.font = UIFont(descriptor: defDescriptor, size: 14.0)
        cardDef.textAlignment = .center
        
        let audioDefButton = CardPartButtonView()     //Button
        audioDefButton.setTitle("Play Sound", for: .normal)
        audioDefButton.addTarget(self, action: #selector(playDefSound), for: .touchUpInside)
        audioDefButton.contentHorizontalAlignment = .center
        
        sv2.addArrangedSubview(cardDef)
        sv2.addArrangedSubview(audioDefButton)
        
        
        /*******FRAME 3: Keyword********/
        let sv3 = CardPartStackView()
        sv3.axis = .vertical
        sv3.spacing = 8
        stackViews.append(sv3)
        let cardImage = CardPartImageView(image: self.image)
        cardImage.imageName = self.key
        cardImage.alpha = 1.0
        
        let buttonImage = CardPartButtonView()
        buttonImage.setTitle("Add Optional Image", for: .normal)
        buttonImage.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        buttonImage.contentHorizontalAlignment = .center
        
        sv3.addArrangedSubview(cardImage)
        sv3.addArrangedSubview(buttonImage)
        /*
         var buttonTitle: String?
         var isSelected: Bool?
         var isHighlighted: Bool?
         var contentHorizontalAlignment: UIControlContentHorizontalAlignment
         var alpha: CGFloat
         var backgroundColor: UIColor?
         var isHidden: Bool
         var isUserInteractionEnabled: Bool
         var tintColor: UIColor?
         */
        
        let cardPartPagedView = CardPartPagedView(withPages: stackViews, andHeight: 400)
        setupCardParts([cardPartTextView, cardPartPagedView])
    }
    
    @objc func buttonTapped() {
        
        let alertController = UIAlertController(title: "Woohoo!", message: "Isn't that awesome!?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func playKeySound() {
        
        let lang: String = "en-US"
        self.readText(myText: self.key, myLang: lang)
    }
    
    @objc func playDefSound() {
        
        let lang: String = "en-US"
        self.readText(myText: self.definition, myLang: lang)
    }
    
    func readText(myText: String, myLang: String)
    {
        
        if(!isPlayingSound)
        {
        let utterance = AVSpeechUtterance(string: myText)
        utterance.voice = AVSpeechSynthesisVoice(language: myLang)
        utterance.rate = 0.5
        synthesizer.speak(utterance)
        isPlayingSound = true
        }
        else
        {
            synthesizer.stopSpeaking(at: .word)
            isPlayingSound = false
        }

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

