//
//  PortfolioDetailViewController.swift
//  portfolio
//
//  Created by iOS Developer on 26/02/16.
//  Copyright © 2016 Xperts Infosoft. All rights reserved.
//

import UIKit
import Alamofire

class PortfolioDetailViewController: BaseViewController {
    
    @IBOutlet var viewPlaystore: UIView!
    @IBOutlet var viewItunes: UIView!
    @IBOutlet var viewCall: UIView!
    @IBOutlet var itunesWidth: NSLayoutConstraint!
    @IBOutlet var playstoreWidth: NSLayoutConstraint!
    @IBOutlet var lblAppName: UILabel!
    @IBOutlet var collImages: UICollectionView!
    
    internal var selectedIndex: Int = 0
    internal var apps = [AppModel]()
    
    //MARK: - vc life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let app = self.apps[self.selectedIndex]
        self.lblAppName.text = app.name
        if (app.images.count > 0) {
            self.bindUiWithApp(app)
        } else {
            self.setEqualWidths()
            self.sendDataToServerWithTask(.TaskGetAppDetails)
        }
        self.collImages.registerClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        self.addTapGesture()
    }
    
    //MARK: UI
    
    func bindUiWithApp(app: AppModel) {
        if (app.isAvailableOnItunes && app.isAvailableOnPlaystore) {
            self.setEqualWidths()
        } else {
            let halfWidth = screenSize().width/2
            if (app.isAvailableOnItunes) {
                self.itunesWidth.constant = halfWidth
                self.playstoreWidth.constant = 0
            } else {
                self.itunesWidth.constant = 0
                self.playstoreWidth.constant = halfWidth
            }
        }
        UIView.animateWithDuration(0.4, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func setEqualWidths() {
        let width = screenSize().width/3
        self.itunesWidth.constant = width
        self.playstoreWidth.constant = width + 1
    }
    
    //MARK: call service
    
    func sendDataToServerWithTask(taskType: AFManager.TaskType) {
        
        self.showActivityIndicator(self.view)
        
        switch taskType {
        case .TaskGetAppDetails:
            let app = self.apps[self.selectedIndex]
            var postDict : Dictionary<String, AnyObject> = Dictionary()
            postDict.updateValue(app.Id, forKey: kId)
            
            let url = baseUrl + "portfolio-detail"
            
            Alamofire.request(.POST, url, parameters: postDict, encoding: .URL, headers: nil).responseJSON() {
                data in
                if (data.response != nil) {
                    self.recievedServiceResponse(data.data!, task: taskType)
                } else {
                    print(data.result.error)
                }
            }
            
        default: break
            
        }
    }
    
    //MARK: service response
    
    func recievedServiceResponse(responseData: NSData, task: AFManager.TaskType) {
        self.hideActivityIndicator()
        
        do {
            let responseDict = try NSJSONSerialization.JSONObjectWithData(responseData, options: []) as! [String:AnyObject]
            let status = responseDict[kStatus] as! Int
            if (status == 1) {
                let portfolioDict = responseDict["portFolio"]
                let app = AppModel.init(response: portfolioDict)
                self.apps[self.selectedIndex] = app
                self.bindUiWithApp(app)
                self.collImages.reloadData()
            } else {
                print(responseDict["error"])
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    //MARK: gesture
    
    func addTapGesture() {
        self.viewCall.addTapRecognizerWithTarget(self, action: Selector(callClicked()))
        //self.viewItunes.addTapRecognizerWithTarget(self, action: Selector(itunesClicked()))
        self.viewPlaystore.addTapRecognizerWithTarget(self, action: Selector(playstoreClicked()))
    }

    func playstoreClicked() {
        let app = self.apps[self.selectedIndex]
        let url = NSURL.init(string: app.playstoreLink)!
        if (UIApplication.sharedApplication().canOpenURL(url)) {
            //UIApplication.sharedApplication().openURL(url)
        } else {
            print("unable to open playstore link")
        }
    }
    
    func itunesClicked() {
        let app = self.apps[self.selectedIndex]
        let url = NSURL.init(string: app.itunesLink)!
        if (UIApplication.sharedApplication().canOpenURL(url)) {
            UIApplication.sharedApplication().openURL(url)
        } else {
            print("unable to open itunes link")
        }
    }

}

//MARK: - collection view data source

extension PortfolioDetailViewController : UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let app = self.apps[self.selectedIndex]
        return app.images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = "cell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath)
        for subview in cell.subviews {
            subview.removeFromSuperview()
        }
        
        let cellSize = cell.frame.size
        let img = UIImageView.init(frame: CGRectMake(0, 0, cellSize.width * 0.7, cellSize.height * 0.9))
        img.center = CGPointMake(cellSize.width/2, cellSize.height/2)
        img.contentMode = .ScaleAspectFit
        let app = self.apps[self.selectedIndex]
        let urlString = app.images[indexPath.row]
        let url = NSURL.init(string: urlString)!
        let placeholder = UIImage.init(named: "vertical_placeholder.jpg")
        img.setImageWithUrl(url, placeHolderImage: placeholder)
        cell.addSubview(img)
        
        return cell
    }
}

//MARK: - collection view delegate

extension PortfolioDetailViewController : UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        //
    }
}

//MARK: - collection view flow layout

extension PortfolioDetailViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return collectionView.frame.size
    }
}