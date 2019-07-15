//
//  ViewController.swift
//  DrawFeature
//
//  Created by Ryan Chang on 7/13/19.
//  Copyright © 2019 Ryan Chang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let canvas=Canvas()
    
    //creates share button
    let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Share", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleShare), for: .touchUpInside)
        return button
    }()
    
    //
    //NEEDS WORK: DIRECTING SHARED PHOTO; turning canvas into image
    @objc func handleShare(){

 
        share()
        
    }
    
    
    //create undo button
    let undoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Undo", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleUndo), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleUndo(){
        canvas.undo()
        
    }
    
    //creates clear button
    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        return button
    }()
    
    @objc func handleClear(){
        canvas.clear()
    }
    
    //buttons
    let yellowButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    let redButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    let blueButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    let blackButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    let greenButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .green
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleColorChange(button: UIButton){
        canvas.setStrokeColor(color: button.backgroundColor ?? .black)
    }
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue=1
        slider.maximumValue=10
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    @objc fileprivate func handleSliderChange(){
        canvas.setStrokeWidth(width: slider.value)
    }
    
    //setup background as white
    override func loadView() {
        self.view=canvas
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //setup background to white
        canvas.backgroundColor = .white
        
        setupLayout()
    }
    
    fileprivate func setupLayout(){
        
        //the stack of buttons
        let colorsStackView = UIStackView (arrangedSubviews:[blackButton,
                                                        yellowButton,
                                                        redButton,
                                                        blueButton,
                                                        greenButton])
        
        colorsStackView.distribution = .fillEqually
        
        
        let stackView=UIStackView(arrangedSubviews: [undoButton,
                                                    colorsStackView,
                                                    clearButton,
                                                    slider,
                                                    shareButton])
        stackView.spacing = 1
        stackView.distribution = .fillEqually
        
        //for location of buttons
        view.addSubview(stackView)
        
        //to manually move buttons
        //stackView.frame = CGRect(x:200,y:200,width:200, height:200)
        
        //places buttons
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -8).isActive = true

        
    }
   func share(){

    let renderer = UIGraphicsImageRenderer(size: canvas.bounds.size)
            let CanvasImage = renderer.image { ctx in
               canvas.drawHierarchy(in: canvas.bounds, afterScreenUpdates: true)
                
    }
    
    let activity = UIActivityViewController(activityItems: [CanvasImage], applicationActivities: nil)
    present(activity, animated: true)
    }
}



