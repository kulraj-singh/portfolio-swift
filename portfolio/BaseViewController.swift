//
//  BaseViewController.swift
//  portfolio
//
//  Created by Kulraj Singh on 10/11/15.
//  Copyright © 2015 Xperts Infosoft. All rights reserved.
//

import UIKit
import Alamofire

class BaseViewController: UIViewController {
    
    var alertController = UIAlertController.init()
    var appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let loadingView: UIView = UIView()
    
    //MARK: vc life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func leftBarButtonClicked(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func rightBarButtonClicked(sender: AnyObject) {
        for viewController in (self.navigationController?.viewControllers)! {
            if (viewController.isKindOfClass(HomeViewController.classForCoder())) {
                self.navigationController?.popToViewController(viewController, animated: true)
            }
        }
    }
    
    internal func callClicked() {
        
    }
    
    // MARK: loader

    func showActivityIndicator(uiView: UIView) {
        let container: UIView = UIView()
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColor.hexToRgb(0xffffff, alpha: 0.1)
        container.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        self.loadingView.frame = CGRectMake(0, 0, 80, 80)
        self.loadingView.center = uiView.center
        self.loadingView.autoresizingMask = [.FlexibleLeftMargin, .FlexibleRightMargin, .FlexibleBottomMargin, .FlexibleTopMargin]
        self.loadingView.backgroundColor = UIColor.hexToRgb(0x444444, alpha: 0.7)
        self.loadingView.clipsToBounds = true
        self.loadingView.layer.cornerRadius = 10
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        actInd.activityIndicatorViewStyle =
        UIActivityIndicatorViewStyle.WhiteLarge
        actInd.center = CGPointMake(loadingView.frame.size.width / 2,
        loadingView.frame.size.height / 2);
        actInd.autoresizingMask = [.FlexibleLeftMargin, .FlexibleRightMargin, .FlexibleBottomMargin, .FlexibleTopMargin]
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        actInd.startAnimating()
    }
    
    func hideActivityIndicator() {
        self.loadingView.superview!.removeFromSuperview()
    }
    
    //MARK: alert
    
    internal func alert(message: String) {
        self.alert(nil, message: message, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: ["OK"], style: .Alert, tag: 0)
    }
    
    internal func alert(message: String, presentingViewController: UIViewController, tag: Int) {
        self.alert(nil, message: message, delegate: presentingViewController, cancelButtonTitle: nil, otherButtonTitles: ["OK"], style: .Alert, tag: tag)
    }
    
    internal func alert(title: String?, message: String, delegate:AnyObject?, cancelButtonTitle: String?, otherButtonTitles: Array<String>, style: UIAlertControllerStyle, tag: Int) {
        self.alertController = UIAlertController.init(title: title, message: message, preferredStyle: style)
        if (cancelButtonTitle != nil) {
            let cancelAction = UIAlertAction.init(title: cancelButtonTitle, style: UIAlertActionStyle.Cancel, handler: {
                _ in
                self.alertController.dismissViewControllerAnimated(true, completion: nil)
                self.alertControllerCancelled()
            })
            self.alertController.addAction(cancelAction)
        }
        
        for buttonTitle in otherButtonTitles {
            let okAction = UIAlertAction.init(title: buttonTitle, style: UIAlertActionStyle.Default, handler: {
                action in
                self.alertController.dismissViewControllerAnimated(true, completion: nil)
                let buttonIndex = otherButtonTitles.indexOf(buttonTitle)
                self.alertButtonClicked(buttonIndex!, tag: tag)
            })
            self.alertController.addAction(okAction)
        }
        
        self.presentViewController(self.alertController, animated: true, completion: nil)
    }
    
    internal func addTextFieldToAlertWithPlaceholder(placeholder: String) {
        self.addTextFieldToAlertWithPlaceholder(placeholder, secureEntry: false)
    }
    
    internal func addTextFieldToAlertWithPlaceholder(placeholder: String, secureEntry: Bool) {
        self.alertController.addTextFieldWithConfigurationHandler() {
            textField in
            textField.placeholder = placeholder
            textField.secureTextEntry = secureEntry
        }
    }
    
    //MARK: pseudo alert delegates
    
    internal func alertControllerCancelled() {
        
    }
    
    internal func alertButtonClicked(index: Int, tag: Int) {
        
    }
}
