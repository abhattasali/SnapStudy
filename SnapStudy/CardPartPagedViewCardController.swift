//
//  CardPartPagedViewCardController.swift
//  CardParts_Example

import Foundation
import CardParts
import RxSwift
import RxCocoa
import AVFoundation

class CardPartPagedViewCardController: CardPartsViewController {
    
    let cardPartTextView = CardPartTextView(type: .normal)
    
    var testUIImage : UIImage? = nil

    var key : String = ""
    var definition : String = ""
    var image : UIImage? = nil
    
    var isPlayingSound : Bool = false
    var isPlayingSound2 : Bool = false
    let synthesizer = AVSpeechSynthesizer()
    
    @IBAction func unwindToCardPart(_ sender: UIStoryboardSegue)
    {
        print("UNWIND PLEASE WORK HOLY")
        guard let vc = sender.source as? PaintDisplay else { return }
        self.image = vc.testImage
    }
    
    var cardImage : CardPartImageView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardPartTextView.text = "SnapStudy™"
        cardPartTextView.textAlignment = .right
        cardPartTextView.textColor = UIColor.white
        
        
        var stackViews: [CardPartStackView] = []    //1st Frame is a Keyword, Second Frame is a Definitino
        
        /*******FRAME 1: Keyword********/
        let sv1 = CardPartStackView()
        sv1.axis = .vertical
        sv1.spacing = 8
        stackViews.append(sv1)

        
        let word = CardPartLabel()
        word.text = self.key
        word.textColor = .white
        word.textAlignment = .center
        var descriptor = UIFontDescriptor(name: "Roboto", size: 30.0)
        descriptor = descriptor.addingAttributes([UIFontDescriptor.AttributeName.traits : [UIFontDescriptor.TraitKey.weight: UIFont.Weight.light]])
        word.font = UIFont(descriptor: descriptor, size: 30.0)
        
        let audioKeyButton = CardPartButtonView()
        //audioKeyButton.setTitle("Play Sound", for: .normal)
        audioKeyButton.setImage(UIImage(named: "Audio")?.withRenderingMode(.alwaysOriginal), for: .normal)
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
        //audioDefButton.setTitle("Play Sound", for: .normal)
        audioDefButton.setImage(UIImage(named: "Audio")?.withRenderingMode(.alwaysOriginal), for: .normal)
        audioDefButton.addTarget(self, action: #selector(playDefSound), for: .touchUpInside)
        audioDefButton.contentHorizontalAlignment = .center
        
        sv2.addArrangedSubview(cardDef)
        sv2.addArrangedSubview(audioDefButton)
        
        
        /*******FRAME 3: Keyword********/
        let sv3 = CardPartStackView()
        sv3.axis = .vertical
        sv3.spacing = 8
        stackViews.append(sv3)
        cardImage = CardPartImageView(image: self.image)    //Paint Image if Any
        cardImage?.imageName = self.key
        cardImage?.alpha = 1.0
        /*
         cardPartImage.contentMode = .scaleAspectFit
         cardPartImage.addConstraint(NSLayoutConstraint(item: cardPartImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 300))
         */
        
        
        let buttonImage = CardPartButtonView()                  //Optional Image Button
        buttonImage.setTitle("Add Optional Image", for: .normal)
        buttonImage.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        buttonImage.contentHorizontalAlignment = .center
        
        
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
            synthesizer.stopSpeaking(at: .word)
            isPlayingSound = false
        }
        else {
        let utterance = AVSpeechUtterance(string: myText)
        utterance.voice = AVSpeechSynthesisVoice(language: myLang)
        utterance.rate = 0.5
        synthesizer.speak(utterance)
        isPlayingSound = true
        }
    }
    
    func readText2(myText: String, myLang: String)
    {
        if(!isPlayingSound2) {
            let utterance2 = AVSpeechUtterance(string: myText)
            utterance2.voice = AVSpeechSynthesisVoice(language: myLang)
            utterance2.rate = 0.5
            synthesizer.speak(utterance2)
            isPlayingSound2 = true
        }
        else {
            synthesizer.stopSpeaking(at: .word)
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

