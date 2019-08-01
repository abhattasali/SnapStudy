//
//  FlashDisplay.swift
//  CardParts
//
//  Created by abhattasali on 7/27/2019.
//  Copyright (c) 2019 abhattasali. All rights reserved.
//

import UIKit
import CardParts

class FlashDisplay: CardsViewController
{
    var flashset: FlashSet!
    var image : UIImage? = nil
    /*
     public var setName: String                     //Name of Set, Ex: Biology 101
     public var myWordCards: [String: Flashcard]    //Dictionary Keyword, Definition pair
     public var myDate: String
     */
    var cards: [CardPartsViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateVC()
        loadCards(cards: cards)
    }
    
    @IBAction func unwindToFlashDisplay(_ sender: UIStoryboardSegue) {
        guard let vc = sender.source as? PaintDisplay else { return }
        self.image = vc.testImage
    }
 
    func populateVC() -> Void
    {
        for key in flashset.myWordCards.keys.sorted()
        {
            let a = CardPartPagedViewCardController()
            a.key = key
            a.definition = (flashset.myWordCards[key]?.definition)!
            cards.append(a)
        }
    }
    
    
}

