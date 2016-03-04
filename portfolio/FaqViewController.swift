//
//  FaqViewController.swift
//  portfolio
//
//  Created by iOS Developer on 04/03/16.
//  Copyright © 2016 Xperts Infosoft. All rights reserved.
//

import UIKit

class FaqViewController: BaseViewController {
    
    @IBOutlet var viewCall: UIView!
    @IBOutlet var viewFaq: UIWebView!
    
    //MARK: vc life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewCall.addTapRecognizerWithTarget(self, action: "callClicked")
        
        self.showActivityIndicator(self.view)
        let url = NSURL.init(string: baseUrl + "faq")
        let request = NSURLRequest.init(URL: url!)
        self.viewFaq.loadRequest(request)
    }

}

//MARK: - web view delegate

extension FaqViewController : UIWebViewDelegate {
    
    func webViewDidFinishLoad(webView: UIWebView) {
        self.hideActivityIndicator()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        self.hideActivityIndicator()
        self.alert((error?.localizedDescription)!)
    }
}