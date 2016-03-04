//
//  ViewManipulations.swift
//  portfolio
//
//  Created by Kulraj Singh on 02/12/15.
//  Copyright © 2015 Xperts Infosoft. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    //MARK: - corners and borders
    
    public func roundCornersWithRadius(radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
        self.layer.borderColor = borderColor.CGColor
        self.layer.borderWidth = borderWidth
    }
    
    public func drawBorderWithColor(color: UIColor, width: CGFloat) {
        self.roundCornersWithRadius(0, borderColor: color, borderWidth: width)
    }
    
    public func roundCorners(radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat, corners: UIRectCorner) {
        let maskLayer = CAShapeLayer.init()
        let cornerRadii = CGSizeMake(10, 10)
        maskLayer.path = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: cornerRadii).CGPath
        self.layer.mask = maskLayer
    }
    
    //MARK: - shadow
    
    public func addShadowAndRasterize(shouldRasterize: Bool, offset: CGSize) {
        let layer = self.layer
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.3
        layer.shouldRasterize = shouldRasterize
    }
    
    public func addShadowAndRasterize(shouldRasterize: Bool) {
        self.addShadowAndRasterize(shouldRasterize, offset: CGSizeMake(2, 2))
    }
    
    //MARK: - animation
    
    public func translateWithOffset(offset: CGPoint, duration: NSTimeInterval) {
        var frame = self.frame
        frame.origin.x += offset.x
        frame.origin.y += offset.y
        
        self.animateToFrame(frame, duration: duration)
    }
    
    public func animateToFrame(finalFrame: CGRect, duration: NSTimeInterval) {
        UIView.animateWithDuration(duration, animations: { _ in
            self.frame = finalFrame
        })
    }
    
    //MARK: - gesture
    
    public func addTapRecognizerWithTarget(target: AnyObject, action: Selector) {
        let tapRecognizer = UITapGestureRecognizer.init(target: target, action: action)
        self.userInteractionEnabled = true
        self.addGestureRecognizer(tapRecognizer)
    }
    
    public func addHorizontalSwipeRecognizersWithTarget(target: NSObject, leftSwipeSelector: Selector, rightSwipeSelector:Selector) {
        self.userInteractionEnabled = true
        
        //right swipe
        let rightSwipeRecognizer = UISwipeGestureRecognizer.init(target: target, action: rightSwipeSelector)
        rightSwipeRecognizer.direction = .Left
        self.addGestureRecognizer(rightSwipeRecognizer)
        
        //left swipe
        let leftSwipeRecognizer = UISwipeGestureRecognizer.init(target: target, action: leftSwipeSelector)
        leftSwipeRecognizer.direction = .Right
        self.addGestureRecognizer(leftSwipeRecognizer)
    }
    
    //MARK: - single borders
    
    public func addTopShadeWithWidth(width: CGFloat, color: UIColor) {
        let frame = self.frame
        let viewShade = UIView.init(frame: CGRectMake(frame.origin.x, frame.origin.y - width, frame.size.width, width))
        viewShade.backgroundColor = color
        self.superview?.addSubview(viewShade)
    }
    
    public func addBottomShadeWithWidth(width: CGFloat, color: UIColor) {
        let frame = self.frame
        let frameHeight = frame.size.height
        let viewShade = UIView.init(frame: CGRectMake(frame.origin.x, frame.origin.y + frameHeight, frame.size.width, width))
        viewShade.backgroundColor = color
        self.superview?.addSubview(viewShade)
    }
    
    public func addLeftBorderWithWidth(width: CGFloat, color: UIColor) {
        let frame = self.frame
        let viewShade = UIView.init(frame: CGRectMake(frame.origin.x - width, frame.origin.y, width, frame.size.height))
        viewShade.backgroundColor = color
        self.superview?.addSubview(viewShade)
    }
    
    public func addRightBorderWithWidth(width: CGFloat, color: UIColor) {
        let frame = self.frame
        let viewShade = UIView.init(frame: CGRectMake(frame.origin.x + frame.size.width, frame.origin.y - width, width, frame.size.height))
        viewShade.backgroundColor = color
        self.superview?.addSubview(viewShade)
    }
}
