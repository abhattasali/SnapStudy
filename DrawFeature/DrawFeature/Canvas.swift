//
//  File.swift
//  DrawFeature
//
//  Created by Ryan Chang on 7/14/19.
//  Copyright © 2019 Ryan Chang. All rights reserved.
//

import UIKit

class Canvas: UIView{
    
    
    fileprivate var strokeColor = UIColor.black
    fileprivate var strokeWidth: Float = 1
    
    func setStrokeWidth(width : Float){
        self.strokeWidth =  width 
    }
    
    func setStrokeColor(color: UIColor){
        self.strokeColor = color 
    }
    
    func undo(){
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear(){
        _ = lines.removeAll()
        setNeedsDisplay()
    }
    
    //var for lines
    fileprivate var lines = [Line]()
    
    //function for drawing
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        //guard let to get rid of non-optional value
        guard let context=UIGraphicsGetCurrentContext()
            else { return }
        
        
        
        lines.forEach { (line) in
            //sets starting color
            context.setStrokeColor(line.color.cgColor)
            //sets starting line length
            context.setLineWidth(CGFloat(line.strokeWidth))
            //sets line point shape
            context.setLineCap(.round)
            
            //p keeps track of line index
            //i to index these points
            for (i,p) in line.points.enumerated(){
                
                //creates first point in line
                if (i == 0){
                    context.move(to: p)
                }
                else {
                    context.addLine(to: p)
                }
            }
            //strokePath draws a simple line
            context.strokePath()

        }
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(strokeWidth: strokeWidth, color: strokeColor, points: []))
    }
    
    //function to track finger movement as it touches the screen
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil)
            else { return }
        
        
        //lets us have multiple lines
        guard var lastLine = lines.popLast()
            else { return }
        lastLine.points.append(point)
        lines.append(lastLine)
        
        //echoes the line to display
        setNeedsDisplay()
    }
}



