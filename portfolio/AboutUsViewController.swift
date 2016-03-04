//
//  AboutUsViewController.swift
//  portfolio
//
//  Created by iOS Developer on 03/03/16.
//  Copyright © 2016 Xperts Infosoft. All rights reserved.
//

import UIKit
import Alamofire

class AboutUsViewController: BaseViewController {
    
    @IBOutlet var viewCall: UIView!
    @IBOutlet var collAboutUs: UICollectionView!
    var contents = [ContentModel]()
    
    //MARK: vc life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewCall.addTapRecognizerWithTarget(self, action: "callClicked:")
        self.collAboutUs.registerClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        self.sendDataToServerWithTask(.TaskAboutUs)
    }
    
    //MARK: call service
    
    func sendDataToServerWithTask(taskType: AFManager.TaskType) {
        
        self.showActivityIndicator(self.view)
        
        switch taskType {
        case .TaskAboutUs:
            let url = baseUrl + "aboutus"
            
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
                switch task {
                case .TaskAboutUs:
                    let aboutDict = responseDict["aboutsus"] as! Dictionary<String, AnyObject>
                    
                    let thinkingContent = ContentModel()
                    thinkingContent.header = "Thinking crossway"
                    thinkingContent.paragraphs = [aboutDict["content"]!]
                    thinkingContent.paragraphs.append(aboutDict["content2"]!)
                    thinkingContent.paragraphs.append(aboutDict["content3"]!)
                    self.contents.append(thinkingContent)
                    
                    let aboutContent = ContentModel()
                    aboutContent.header = "About Us..."
                    aboutContent.paragraphs = [aboutDict["content4"]!]
                    aboutContent.paragraphs.append(aboutDict["content5"]!)
                    aboutContent.paragraphs.append("")
                    self.contents.append(aboutContent)
                    
                    let industryContent = ContentModel()
                    industryContent.header = "App industry"
                    industryContent.backgroundColor = UIColor.redColor()
                    industryContent.paragraphs = [aboutDict["content6"]!]
                    industryContent.paragraphs.append([aboutDict["content6"]!])
                    industryContent.paragraphs.append([aboutDict["content7"]!])
                    industryContent.paragraphs.append([aboutDict["content8"]!])
                    industryContent.paragraphs.append([aboutDict["content9"]!])
                    self.contents.append(industryContent)
                    
                    self.collAboutUs.reloadData()
                    
                default:
                    break
                }
            } else {
                let err = responseDict[kError] as! String
                self.alert(err)
            }
        } catch let error as NSError {
            self.alert("Failed to load: \(error.localizedDescription)")
        }
    }

}

//MARK: - collection view data source

extension AboutUsViewController : UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.contents.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = "cell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath)
        for subview in cell.subviews {
            subview.removeFromSuperview()
        }
        let cellSize = cell.frame.size
        let margin = 20 as CGFloat
        
        let aboutScroller = NSBundle.mainBundle().loadNibNamed("AboutUsScrollView", owner: self, options: nil).first as! AboutUsScrollView
        aboutScroller.cellType = Cell(rawValue: indexPath.row)!
        aboutScroller.frame = CGRectMake(0, 0, cellSize.width, cellSize.height - margin)
        
        let content = self.contents[indexPath.row]
        aboutScroller.bindContent(content)
        cell.backgroundColor = content.backgroundColor
        cell.addSubview(aboutScroller)
        
        return cell
    }
}

//MARK: - collection view delegate

extension AboutUsViewController : UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        //
    }
}

//MARK: - collection view flow layout

extension AboutUsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSizeMake(size.width, size.height - 30)
    }
}
