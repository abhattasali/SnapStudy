//
//  Created by abhattasali on 7/27/2019.
//  Copyright (c) 2019 abhattasali. All rights reserved.

import Foundation
import CardParts
import RxSwift
import RxCocoa
import AVFoundation

class CardPartPagedViewCardController: CardPartsViewController
{
    
    let cardPartTextView = CardPartTextView(type: .normal)
    var testUIImage : UIImage? = nil
    var key : String = ""
    var definition : String = ""
    var image : UIImage? = nil
    
    var isPlayingSound : Bool = false
    var isPlayingSound2 : Bool = false
    let synthesizer = AVSpeechSynthesizer()
    
    var cardImage : CardPartImageView? = nil
    var dyslexieBool : Bool = false
    var myFont : String = "Roboto"
   
    
    override func viewDidLoad()
    {
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        dyslexieBool = appDel.isDyslexieOn
        if(dyslexieBool) {
            myFont = "OpenDyslexicAlta-Regular"
        }
        
        super.viewDidLoad()
        cardPartTextView.text = "SnapStudy™"
        var tm = UIFontDescriptor(name: "Roboto", size: 19.0)
        tm = tm.addingAttributes([UIFontDescriptor.AttributeName.traits : [UIFontDescriptor.TraitKey.weight : UIFont.Weight.light]])
        cardPartTextView.font = UIFont(descriptor: tm, size: 19.0)
        cardPartTextView.textAlignment = .right
        cardPartTextView.textColor = UIColor.white
        
        
        var stackViews: [CardPartStackView] = []    //1st Frame is a Keyword, Second Frame is a Definitino
        
        /******* CARD FRAME 1: Keyword ********/
        let sv1 = CardPartStackView()
        sv1.axis = .vertical
        sv1.spacing = 8
        stackViews.append(sv1)

        
        let word = CardPartLabel()
        word.text = self.key
        word.textColor = .white
        word.textAlignment = .center
        var descriptor = UIFontDescriptor(name: myFont, size: 33.0)
        descriptor = descriptor.addingAttributes([UIFontDescriptor.AttributeName.traits : [UIFontDescriptor.TraitKey.weight: UIFont.Weight.light]])
        word.font = UIFont(descriptor: descriptor, size: 33.0)
        
        let audioKeyButton = CardPartButtonView()
        //audioKeyButton.setTitle("Play Sound", for: .normal)
        audioKeyButton.setImage(UIImage(named: "Audio")?.withRenderingMode(.alwaysOriginal), for: .normal)
        audioKeyButton.addTarget(self, action: #selector(playKeySound), for: .touchUpInside)
        audioKeyButton.contentHorizontalAlignment = .center
        
        
        sv1.addArrangedSubview(word)
        sv1.addArrangedSubview(audioKeyButton)
        
        
        /******* CARD FRAME 2: Keyword********/
        //Definition Text
        let sv2 = CardPartStackView()
        sv2.axis = .vertical
        sv2.spacing = 8
        stackViews.append(sv2)
        
        let cardDef = CardPartTextView(type: .normal)
        cardDef.text = self.definition
        cardDef.textColor = .white
        var defDescriptor = UIFontDescriptor(name: myFont, size: 14.0)
        defDescriptor = defDescriptor.addingAttributes([UIFontDescriptor.AttributeName.traits : [UIFontDescriptor.TraitKey.weight : UIFont.Weight.light]])
        cardDef.font = UIFont(descriptor: defDescriptor, size: 14.0)
        cardDef.textAlignment = .center
        
        //Audio Button for Definition
        let audioDefButton = CardPartButtonView()
        audioDefButton.setImage(UIImage(named: "Audio")?.withRenderingMode(.alwaysOriginal), for: .normal)
        audioDefButton.addTarget(self, action: #selector(playDefSound), for: .touchUpInside)
        audioDefButton.contentHorizontalAlignment = .center
        
        sv2.addArrangedSubview(cardDef)
        sv2.addArrangedSubview(audioDefButton)
        
        
        /******* CARD FRAME 3: Keyword********/
        let sv3 = CardPartStackView()
        sv3.axis = .vertical
        sv3.spacing = 8
        stackViews.append(sv3)
        cardImage = CardPartImageView(image: self.image)    //Paint Image if Any
        cardImage?.imageName = self.key
        cardImage?.alpha = 1.0
       
    
        
        
        let buttonImage = CardPartButtonView()                  //Optional Image Button
        buttonImage.setTitle("Add Optional Image", for: .normal)
        buttonImage.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        buttonImage.contentHorizontalAlignment = .center
        buttonImage.backgroundColor = .black
        buttonImage.setTitleColor(.white, for: .normal)
        
        buttonImage.layer.cornerRadius = 10
        
        
        sv3.addArrangedSubview(cardImage!)
        sv3.addArrangedSubview(buttonImage)
        
        let cardPartPagedView = CardPartPagedView(withPages: stackViews, andHeight: 400)
        setupCardParts([cardPartTextView, cardPartPagedView])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? PaintDisplay else { return }
        vc.testImage = self.image
    }
    
    func receiveDataFromModal( theImg: UIImage) {
        cardImage?.image = theImg
    }
    
    @objc func buttonTapped()
    {
        let appDel = UIApplication.shared.delegate as? AppDelegate
        appDel?.curCardController = self
        self.present(PaintDisplay(), animated: true, completion: nil)
    }
    
    @objc func playKeySound() {
        
        let lang: String = "en-US"
        self.readText(myText: self.key, myLang: lang)
    }
    
    @objc func playDefSound() {
        
        let lang: String = "en-US"
        self.readText2(myText: self.definition, myLang: lang)
    }
    
    func readText(myText: String, myLang: String)
    {
        if(isPlayingSound) {
            synthesizer.stopSpeaking(at: .immediate)
            isPlayingSound = false
        }
        else {
        let utterance = AVSpeechUtterance(string: myText)
        //utterance.voice = AVSpeechSynthesisVoice(language: myLang)
        utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Karen-compact")
        utterance.rate = 0.55
        synthesizer.speak(utterance)
        isPlayingSound = true
        }
    }
    
    func readText2(myText: String, myLang: String)
    {
        if(!isPlayingSound2) {
            let utterance2 = AVSpeechUtterance(string: myText)
            //utterance2.voice = AVSpeechSynthesisVoice(language: myLang)
            utterance2.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Karen-compact")
            utterance2.rate = 0.55
            synthesizer.speak(utterance2)
            isPlayingSound2 = true
        }
        else {
            synthesizer.stopSpeaking(at: .immediate)
            isPlayingSound2 = false
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

class CustomSegue : UIStoryboardSegue
{
    override func perform() {
        let src = self.source as UIViewController
        let dst = self.destination as UIViewController
        src.navigationController?.pushViewController(dst, animated: false)
    }
}

