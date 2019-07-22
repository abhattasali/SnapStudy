//
//  FlashSet.swift
//  SnapStudy
//
//  Created by Arun Bhattasali on 7/22/19.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import Foundation
import UIKit

class FlashSet
{
    var setName: String                     //Name of Set, Ex: Biology 101
    var myWordCards: [String: Flashcard]    //Dictionary Keyword, Definition pair
    var myDate: String                      //Date in Format: "October 8, 2016"
    
    init(setName: String = "Bio", myWordCards: [String: Flashcard] = [String: Flashcard]())
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
    var keyword: String
    var definition: String
    var image: UIImage
    
    init(keyword: String, definition: String, image: UIImage? = nil)
    {
        self.keyword = keyword
        self.definition = definition
        self.image = image!
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
