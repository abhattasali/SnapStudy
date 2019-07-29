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
    
    let keys = ["Hi", "There", "World"]
    let definitions = ["1","2","3"]
    var cards: [CardPartsViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populate()
        // Comment out one of the CardPartViewController in the card Array to change cards and/or their order
        
        
        
        //loadCards(cards: cards)
        /*cards.append(CardPartPagedViewCardController())
        cards.append(CardPartPagedViewCardController())
        cards.append(CardPartPagedViewCardController())
        cards.append(CardPartPagedViewCardController())
        cards.append(CardPartPagedViewCardController())*/
        
        //a.key = "Hello"
        loadCards(cards: cards)
    }
    
    func populate() -> Void
    {
        for k in 0...2 {
            let a = CardPartPagedViewCardController()
            a.key = keys[k]
            a.definition = definitions[k]
            cards.append(a)
        }
    }
    
    
}

