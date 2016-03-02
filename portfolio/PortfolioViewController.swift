//
//  PortfolioViewController.swift
//  portfolio
//
//  Created by Kulraj Singh on 01/01/16.
//  Copyright © 2016 Xperts Infosoft. All rights reserved.
//

import UIKit
import Alamofire
import KFSwiftImageLoader

class PortfolioViewController : BaseViewController {
    
    @IBOutlet var collApps : UICollectionView!
    @IBOutlet var viewCall : UIView!
    var apps = [AppModel]()
    let nameLabelSize: CGFloat = 50
    
    //MARK: - vc life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.viewCall.addTapRecognizerWithTarget(self, action: Selector(callClicked()))
        self.sendDataToServerWithTask(.TaskPortfolioList)
        self.collApps.registerClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: call service
    
    func sendDataToServerWithTask(taskType: AFManager.TaskType) {
        
        self.showActivityIndicator(self.view)
        
        switch taskType {
        case .TaskPortfolioList:
            let url = baseUrl + "portfolio"
            
            Alamofire.request(.GET, url).responseJSON() {
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
                let apps = responseDict["portFolioList"] as! [Dictionary<String, AnyObject>]
                for appDict in apps {
                    let app = AppModel.init(response: appDict)
                    self.apps.append(app)
                }
                self.collApps.reloadData()
            } else {
                print("error")
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    //MARK: gesture
    
    @IBAction func callClicked(sender: AnyObject) {
        
    }
    
    //MARK: - button clicks
    
    @IBAction func rightBarButtonClicked(sender: AnyObject) {
        
    }

}

//MARK: -
extension PortfolioViewController : UICollectionViewDataSource {
    
    //MARK: collection view data source
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let itemCount = self.apps.count
        return itemCount
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "cell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) 
        
        //configure the cell
        
        for subview in cell.subviews {
            subview.removeFromSuperview()
        }
        
        //image
        let cellWidth = cell.frame.size.width
        let margin = 5 as CGFloat
        let imgWidth = cellWidth - 2 * margin
        let img = UIImageView.init(frame: CGRectMake(margin, 0, imgWidth, imgWidth))
        let app = self.apps[indexPath.row]
        img.roundCornersWithRadius(10, borderColor: UIColor.clearColor(), borderWidth: 1)
        let url = NSURL.init(string: app.thumbnailLink)
        img.setImageWithUrl(url!, placeHolderImage: UIImage.init(named: "logo512X512"))
        cell.addSubview(img)
        
        //image name
        let lblName = UILabel.init(frame: CGRectMake(margin, imgWidth + margin, imgWidth, self.nameLabelSize - margin))
        lblName.text = app.name
        lblName.textColor = UIColor.blackColor()
        lblName.numberOfLines = 0
        lblName.font = UIFont.systemFontOfSize(14)
        lblName.textAlignment = NSTextAlignment.Center
        cell.addSubview(lblName)

        return cell
    }
}

//MARK: - collection view delegate

extension PortfolioViewController : UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let portfolioDetailVc = PortfolioDetailViewController.init(nibName: "PortfolioDetailViewController", bundle: nil)
        portfolioDetailVc.selectedIndex = indexPath.row
        portfolioDetailVc.apps = self.apps
        self.navigationController?.pushViewController(portfolioDetailVc, animated: true)
    }
}

//MARK: - collection view flow layout

extension PortfolioViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let width = screenSize().width/3
        return CGSizeMake(width, width + self.nameLabelSize)
    }
}
