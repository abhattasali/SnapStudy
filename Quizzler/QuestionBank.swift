//
//  QuestionBank.swift
//  Quizzler
//


import Foundation

class QuestionBank {
    
    var list = [ChoiceQuestion]()
    
    init(){
      let question1=ChoiceQuestion()
        question1.setText(question1: "Where in plants does most photosynthesis occur?")
        question1.addChoice(choice: "Flowers", correct: false)
        question1.addChoice(choice: "Branches", correct: false)
        question1.addChoice(choice: "Leaves", correct: true)
        question1.addChoice(choice: "Roots", correct: false)
        let question2=ChoiceQuestion()
        question2.setText(question1: "Where in plants do carbon dioxide and oxygen enter/exit?")
        question2.addChoice(choice: "Stomata of leaves", correct: true)
        question2.addChoice(choice: "Stem", correct: false)
        question2.addChoice(choice: "Root tips", correct: false)
        question2.addChoice(choice: "Holes", correct: false)
        let question3=ChoiceQuestion()
        question3.setText(question1: "What is the name of the green pigment that captures light for photosynthesis?")
        question3.addChoice(choice: "Cytoplasm", correct: false)
        question3.addChoice(choice: "Chloroplast", correct: false)
        question3.addChoice(choice: "Green Pigment", correct: false)
        question3.addChoice(choice: "Chlorophyll", correct: true)
        let question4=ChoiceQuestion()
        question4.setText(question1: "Which of the following organisms can perform photosynthesis?")
        question4.addChoice(choice: "Old People", correct: false)
        question4.addChoice(choice: "Animals", correct: false)
        question4.addChoice(choice: "Plants", correct: true)
        question4.addChoice(choice: "Bacteria", correct: false)
        let question5=ChoiceQuestion()
        question5.setText(question1: "The process by which plants and some other organisms convert light energy to chemical energy is ______")
        question5.addChoice(choice: "Germination", correct: false)
        question5.addChoice(choice: "Botany", correct: false)
        question5.addChoice(choice: "Gardening", correct: false)
        question5.addChoice(choice: "Photosynthesis", correct: true)
        let question6=ChoiceQuestion()
        question6.setText(question1: "What is the byproduct of photosynthesis?")
        question6.addChoice(choice: "Carbondioxide", correct: false)
        question6.addChoice(choice: "Oxygen", correct: true)
        question6.addChoice(choice: "Carbonmonoxide", correct: false)
        question6.addChoice(choice: "Methane", correct: false)
        let question7=ChoiceQuestion()
        question7.setText(question1: "Plants are green because chlorophyll ____________ green light?")
        question7.addChoice(choice: "Absorb", correct: true)
        question7.addChoice(choice: "Reflect", correct: false)
        question7.addChoice(choice: "Resist", correct: false)
        question7.addChoice(choice: "Retracts", correct: false)
        let question8=ChoiceQuestion()
        question8.setText(question1: "The ___ theory is that the carbondioxide is reduced to carbonmonoxide?")
        question8.addChoice(choice: "Einstein", correct: false)
        question8.addChoice(choice: "Million", correct: false)
        question8.addChoice(choice: "Baeyer's", correct: true)
        question8.addChoice(choice: "Secrue", correct: false)
        let question9=ChoiceQuestion()
        question9.setText(question1: "?")
        question9.addChoice(choice: "4", correct: true)
        question9.addChoice(choice: "0", correct: false)
        question9.addChoice(choice: "11", correct: false)
        question9.addChoice(choice: "13", correct: false)
        let question10=ChoiceQuestion()
        question10.setText(question1: "?")
        question10.addChoice(choice: "26", correct: false)
        question10.addChoice(choice: "5", correct: false)
        question10.addChoice(choice: "98", correct: true)
        question10.addChoice(choice: "11", correct: false)
        
        list.append(question1)
        list.append(question2)
        list.append(question3)
        list.append(question4)
        
      list.append(question5)
        list.append(question6)
        list.append(question7)
        list.append(question8)
        list.append(question9)
        list.append(question10)
    }
    
}
