//
//  DrawArtView.swift
//  DrawSend
//
//  Created by Daniel Brim on 3/21/15.
//  Copyright (c) 2015 Daniel Brim. All rights reserved.
//

import UIKit

class DrawArtView: UIView {
    
    var brush: Brush = Brush()
    
    private var incrementalImage: UIImage?
    private var lineSegments: [DrawProtocol] = [DrawProtocol]()
    private var currentSegment: DrawProtocol?
    private var drawingQueue = dispatch_queue_create("drawingQueue", nil)
    private var touchesMoved = false
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clearColor()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    // Cause UIView is stupid and doesn't have a no arg init to override. It calls some
    // superclass's (probs NSObject) no arg constructor, but you can't override it.
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        incrementalImage?.drawInRect(rect)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            let point = touch.locationInView(self)
            
            println("Touches began with point: \(point)")
            dispatch_async(drawingQueue, { () -> Void in
                self.currentSegment = self.brush.copy() as! Brush
                self.currentSegment?.addPoint(point)
                
                self.lineSegments.append(self.currentSegment!)
                
                UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0);
                if let image = self.incrementalImage {
                    image.drawAtPoint(CGPointZero)
                } else {
                    let rectpath = UIBezierPath(rect:self.bounds)
                    self.backgroundColor!.setFill()
                    rectpath.fill()
                }
                self.currentSegment?.draw()
                
                self.incrementalImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.setNeedsDisplay()
                })
            })
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            let point = touch.locationInView(self)
            
            println("Moved with \(touches.count) touches")
            
            dispatch_async(drawingQueue, { () -> Void in
                self.touchesMoved = true
                self.currentSegment?.addPoint(point)
                
                UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0);
                if let image = self.incrementalImage {
                    image.drawAtPoint(CGPointZero)
                }
                self.currentSegment?.draw()
                
                self.incrementalImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.setNeedsDisplay()
                })
            })
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            let point = touch.locationInView(self)
            
            println("Ended with \(touches.count) touches")
            dispatch_async(drawingQueue, { () -> Void in
                if self.touchesMoved {
                    self.currentSegment?.finishWithPoint(point)
                    
                    UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0);
                    if let image = self.incrementalImage {
                        image.drawAtPoint(CGPointZero)
                    }
                    self.currentSegment?.draw()
                    
                    self.incrementalImage = UIGraphicsGetImageFromCurrentImageContext();
                    UIGraphicsEndImageContext();
                    
                    self.touchesMoved = false
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.setNeedsDisplay()
                    })
                }
            })
        }
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        self.touchesEnded(touches, withEvent: event)
    }
    
    // Controls
    func reset() {
        incrementalImage = nil
        lineSegments.removeAll(keepCapacity: true)
        self.setNeedsDisplay()
    }
    
    func undo() {
        lineSegments.removeLast()
        self.setNeedsDisplay()
    }
    
    func undo(count: Int) {
        var start = self.lineSegments.count - count
        if start < 0 {
            start = 0
        }
        let range = Range(start: start, end:self.lineSegments.count)
        
        lineSegments.removeRange(range)
        self.setNeedsDisplay()
    }
}
