//
//  FlashSet.swift
//  SnapStudy
//
//  Created by Arun Bhattasali on 7/22/19.
//  Copyright © 2019 Arun Bhattasali. All rights reserved.


import Foundation
import UIKit

class FlashSet
{
    public var setName: String                     //Name of Set, Ex: Biology 101
    public var myWordCards: [String: Flashcard]    //Dictionary Keyword, Definition pair
    public var myDate: String                      //Date in Format: "October 8, 2016"
    
    init(setName: String = "", myWordCards: [String: Flashcard] = [String: Flashcard]())
    {
        self.setName = setName
        self.myWordCards = myWordCards
        
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .long
        self.myDate = formatter.string(from: currentDateTime)
    }
    
    func getDate() -> String {
        return self.myDate
    }
    
    func getSetName() -> String {
        return self.setName
    }
    
    func getSet() -> [String: Flashcard] {
        return self.myWordCards
    }
}

class Flashcard
{
    public var keyword: String
    public var definition: String
    public var image: UIImage
    
    init(keyword: String, definition: String, image: UIImage)
    {
        self.keyword = keyword
        self.definition = definition
        self.image = image
    }
    
    func getKeyword() -> String {
        return self.keyword
    }
    
    func getDefinition() -> String {
        return self.definition
    }
    
    func getUIImage() -> UIImage {
        return self.image
    }
}
