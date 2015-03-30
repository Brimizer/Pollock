//
//  Brush.swift
//  DrawSend
//
//  Created by Daniel Brim on 3/22/15.
//  Copyright (c) 2015 Daniel Brim. All rights reserved.
//

import UIKit

protocol DrawProtocol: NSCopying {
    func addPoint(point: CGPoint)
    func finishWithPoint(point: CGPoint)
    func draw()
}

/// Brush
/// Subclass this to create custom drawing brushes
public class Brush: NSObject, NSCopying, DrawProtocol {
    
    public var width: CGFloat = 4.0
    public var color: UIColor = UIColor.blackColor()
    public var alpha: CGFloat = 1.0
    
    // These variables help implement this specific brush
    private var path: UIBezierPath = UIBezierPath()

    private var ctr: Int = 0
    private var previous: CGPoint?
    private var current: CGPoint?
    
    public override init() {
        super.init()
    }
    
    public convenience init(color: UIColor, width: CGFloat, alpha: CGFloat) {
        self.init()
        
        self.color = color
        self.width = width
        self.alpha = alpha
    }
    
    public func copyWithZone(zone: NSZone) -> AnyObject {
        let copy = Brush(color: color.copyWithZone(zone) as! UIColor, width: width, alpha: alpha)
        return copy
    }
    
    func startWithPoint(point: CGPoint) {
        
    }
    
    func addPoint(point: CGPoint) {
        
        if ctr == 0 {
            previous = point
            current = point
            
            let midpoint = midPoint(current!, p2: previous!)
            
            path.moveToPoint(current!)
            path.addLineToPoint(current!)
            ctr++
        } else {
            previous = current
            current = point
            
            let midpoint = midPoint(current!, p2: previous!)
            path.addQuadCurveToPoint(midpoint, controlPoint: previous!)
            ctr = 1
        }
    }
    
    func finishWithPoint(point: CGPoint) {
        previous = current
        current = point
        
        if let prev = previous {
            let midpoint = midPoint(current!, p2: previous!)
            path.addQuadCurveToPoint(midpoint, controlPoint: previous!)
        } else {
            path.moveToPoint(point)
        }
        
        previous = nil
        current = nil
    }
    
    func draw() {
        let context: CGContextRef = UIGraphicsGetCurrentContext();
        
        CGContextAddPath(context, path.CGPath);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextSetLineWidth(context, self.width);
        CGContextSetStrokeColorWithColor(context, self.color.CGColor);
        CGContextSetBlendMode(context, kCGBlendModeNormal);
        CGContextSetAlpha(context, 1.0);
        CGContextStrokePath(context);
    }
    
    ///MARK: Private Helpers
    
    // Find the midpoint
    private func  midPoint(p1: CGPoint, p2: CGPoint) -> CGPoint {
        return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
    }
}
