//
//  TextFieldUtility.swift
//  portfolio
//
//  Created by iOS Developer on 09/03/16.
//  Copyright © 2016 Xperts Infosoft. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    //MARK: left view and right view
    
    func addLeftImage(name: String) {
        if let letView = self.leftView {
            for subview in letView.subviews {
                subview.removeFromSuperview()
            }
        }
        let image = UIImage.init(named: name)
        let height = self.frame.size.height
        
        //create a view and add image view
        let paddingView = UIView.init(frame: CGRectMake(0, 0, height, height))
        let imgView = UIImageView.init(frame: CGRectMake(0, 0, height/2, height))
        imgView.center = CGPointMake(height/2, height/2)
        imgView.image = image
        imgView.backgroundColor = UIColor.whiteColor()
        imgView.contentMode = UIViewContentMode.ScaleAspectFit
        paddingView.addSubview(imgView)
        
        self.leftView = paddingView
        self.leftViewMode = UITextFieldViewMode.Always
    }
    
    func addRightImage(name: String) {
        if let rightView = self.rightView {
            for subview in rightView.subviews {
                subview.removeFromSuperview()
            }
        }
        let image = UIImage.init(named: name)
        let height = self.frame.size.height
        
        //create a view and add image view
        let paddingView = UIView.init(frame: CGRectMake(0, 0, height, height))
        let imgView = UIImageView.init(frame: CGRectMake(0, 0, height/2, height))
        imgView.center = CGPointMake(height/2, height/2)
        imgView.image = image
        imgView.backgroundColor = UIColor.whiteColor()
        imgView.contentMode = UIViewContentMode.ScaleAspectFit
        paddingView.addSubview(imgView)
        
        self.rightView = paddingView
        self.rightViewMode = UITextFieldViewMode.Always
    }
    
    func addRightButton(imgName name: String, target: AnyObject, selector: Selector) {
        let image = UIImage.init(named: name)
        let height = self.frame.size.height
        
        //create and add button
        let btn = UIButton.init(frame: CGRectMake(0, 0, height, height))
        btn.center = CGPointMake(height/2, height/2)
        btn.setImage(image, forState: UIControlState.Normal)
        btn.addTarget(target, action: selector, forControlEvents: UIControlEvents.TouchUpInside)
        
        self.rightView = btn
        self.rightViewMode = UITextFieldViewMode.Always
    }
    
    func addLeftPadding(padding: CGFloat) {
        let height = self.frame.size.height
        let paddingView = UIView.init(frame: CGRectMake(0, 0, padding, height))
        self.leftView = paddingView
        self.leftViewMode = UITextFieldViewMode.Always
    }
    
    //MARK: toolbar
    
    func addToolbar(target target: AnyObject, doneSelector: Selector) {
        //done button
        let btnDone = UIButton.init(frame: CGRectMake(0, 0, 60, 40))
        btnDone.setTitle("Done", forState: UIControlState.Normal)
        btnDone.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        btnDone.addTarget(target, action: doneSelector, forControlEvents: UIControlEvents.TouchUpInside)
        btnDone.tag = self.tag
        
        //toolbar with items
        let toolbar = UIToolbar.init(frame: CGRectMake(0, 0, screenSize().width, 44))
        let itemDone = UIBarButtonItem.init(customView: btnDone)
        let itemFlexible = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        toolbar.items = [itemDone, itemFlexible]
        self.inputAccessoryView = toolbar
    }
    
    func addToolbar(target target: AnyObject, doneSelector: Selector, nextSelector: Selector) {
        //done button
        let btnDone = UIButton.init(frame: CGRectMake(0, 0, 60, 40))
        btnDone.setTitle("Done", forState: UIControlState.Normal)
        btnDone.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        btnDone.addTarget(target, action: doneSelector, forControlEvents: UIControlEvents.TouchUpInside)
        btnDone.tag = self.tag
        
        //next button
        let btnNext = UIButton.init(frame: CGRectMake(0, 0, 60, 40))
        btnNext.setTitle("Next", forState: UIControlState.Normal)
        btnNext.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        btnNext.addTarget(target, action: nextSelector, forControlEvents: UIControlEvents.TouchUpInside)
        btnNext.tag = self.tag
        
        //toolbar with items
        let toolbar = UIToolbar.init(frame: CGRectMake(0, 0, screenSize().width, 44))
        let itemDone = UIBarButtonItem.init(customView: btnDone)
        let itemFlexible = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let itemNext = UIBarButtonItem.init(customView: btnNext)
        toolbar.items = [itemDone, itemFlexible, itemNext]
        self.inputAccessoryView = toolbar
    }
}