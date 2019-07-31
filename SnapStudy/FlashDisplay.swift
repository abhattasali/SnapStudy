//
//  MainViewController.swift
//  CardParts
//
//  Created by tkier on 11/27/2017.
//  Copyright (c) 2017 tkier. All rights reserved.
//

import UIKit
import CardParts

class FlashDisplay: CardsViewController {

    var flashset: FlashSet!
    /*
     public var setName: String                     //Name of Set, Ex: Biology 101
     public var myWordCards: [String: Flashcard]    //Dictionary Keyword, Definition pair
     public var myDate: String
     */
    var cards: [CardPartsViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("test on FlashDisplay: \(flashset.getSetName())")
        print()
        print()
        print()
        for w in flashset.myWordCards.keys {
            print("\(w)")
            print("\((flashset.myWordCards[w]?.definition)!)\n\n")
        }
        
        populateVC()
        loadCards(cards: cards)
    
        //loadCards(cards: cards)
        /*cards.append(CardPartPagedViewCardController())
        cards.append(CardPartPagedViewCardController())
        cards.append(CardPartPagedViewCardController())
        cards.append(CardPartPagedViewCardController())
        cards.append(CardPartPagedViewCardController())*/
        
        //a.key = "Hello"
        
    }
 
    func populateVC() -> Void
    {
        //print("MYKEYS XDDDDD \(flashset.myWordCards.keys)")
        for key in flashset.myWordCards.keys.sorted()
        {
            let a = CardPartPagedViewCardController()
            a.key = key
            a.definition = (flashset.myWordCards[key]?.definition)!
            cards.append(a)
        }
    }
    
    
}

