//
//  DrawView.swift
//  DrawSend
//
//  Created by Daniel Brim on 3/19/15.
//  Copyright (c) 2015 Daniel Brim. All rights reserved.
//

import UIKit

public class DrawView: UIView {
    
    public var brush: Brush = Brush() {
        didSet {
            self.drawArtView.brush = brush
        }
    }
    
    public var canvasColor: UIColor = UIColor.whiteColor() {
        didSet {
            self.canvasView.backgroundColor = canvasColor
        }
    }
    
    private var canvasView: UIView!
    private var drawArtView: DrawArtView = DrawArtView()
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor.clearColor()
        
        setupCanvas()
        setupDrawArtView()
    }
    
    func setupCanvas() {
        canvasView = UIView()
        canvasView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.addSubview(canvasView)
        
        let topConstraint = NSLayoutConstraint(item: canvasView, attribute:NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem:self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)
        
        let leftConstraint = NSLayoutConstraint(item: canvasView, attribute:NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem:self, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0)
        
        let rightConstraint = NSLayoutConstraint(item: canvasView, attribute:NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem:self, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(item: canvasView, attribute:NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem:self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        
        self.addConstraint(topConstraint)
        self.addConstraint(leftConstraint)
        self.addConstraint(rightConstraint)
        self.addConstraint(bottomConstraint)
    }
    
    func setupDrawArtView() {
        drawArtView.setTranslatesAutoresizingMaskIntoConstraints(false)
        drawArtView.brush = self.brush
        
        self.addSubview(drawArtView)
        
        let topConstraint = NSLayoutConstraint(item: drawArtView, attribute:NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem:self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)
        
        let leftConstraint = NSLayoutConstraint(item: drawArtView, attribute:NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem:self, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0)
        
        let rightConstraint = NSLayoutConstraint(item: drawArtView, attribute:NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem:self, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(item: drawArtView, attribute:NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem:self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        
        self.addConstraint(topConstraint)
        self.addConstraint(leftConstraint)
        self.addConstraint(rightConstraint)
        self.addConstraint(bottomConstraint)
    }
    
    public func reset() {
        drawArtView.reset()
    }
    
    public func undo() {
        drawArtView.undo()
    }
    
    public func undo(count: Int) {
        drawArtView.undo(count)
    }
}










