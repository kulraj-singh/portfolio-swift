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
    
    var appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let loadingView: UIView = UIView()

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
    
    internal func callClicked() {
        
    }
    
    // MARK: loader

    func showActivityIndicator(uiView: UIView) {
        let container: UIView = UIView()
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColor.hexToRgb(0xffffff, alpha: 0.3)
        
        self.loadingView.frame = CGRectMake(0, 0, 80, 80)
        self.loadingView.center = uiView.center
        self.loadingView.backgroundColor = UIColor.hexToRgb(0x444444, alpha: 0.7)
        self.loadingView.clipsToBounds = true
        self.loadingView.layer.cornerRadius = 10
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        actInd.activityIndicatorViewStyle =
        UIActivityIndicatorViewStyle.WhiteLarge
        actInd.center = CGPointMake(loadingView.frame.size.width / 2,
        loadingView.frame.size.height / 2);
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        actInd.startAnimating()
    }
    
    func hideActivityIndicator() {
        self.loadingView.superview!.removeFromSuperview()
    }

}
