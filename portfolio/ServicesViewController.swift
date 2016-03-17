//
//  ServicesViewController.swift
//  portfolio
//
//  Created by iOS Developer on 04/03/16.
//  Copyright © 2016 Xperts Infosoft. All rights reserved.
//

import UIKit
import Alamofire

class ServicesViewController: BaseViewController {
    
    var imageLinks = [NSURL]()
    @IBOutlet var tblServices: UITableView!
    @IBOutlet var viewCall: UIView!
    
    //MARK: - vc life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewCall.addTapRecognizerWithTarget(self, action: "callClicked")
        self.sendDataToServerWithTask(.TaskServices)
    }
    
    //MARK: - call service
    
    func sendDataToServerWithTask(taskType: AFManager.TaskType) {
        
        self.showActivityIndicator(self.view)
        
        switch taskType {
        case .TaskServices:
            let url = baseUrl + "services"
            
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
                case .TaskServices:
                    let services = responseDict["serviceList"] as! Array<Dictionary<String, String>>
                    for serviceDict in services {
                        let link = NSURL.init(string: serviceDict["image"]!)!
                        self.imageLinks.append(link)
                    }
                    self.tblServices.reloadData()
                    
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

//MARK: - table view data source

extension ServicesViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imageLinks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        } else {
            for subview in (cell?.subviews)! {
                subview.removeFromSuperview()
            }
        }
        
        let cellHeight = self.tableView(tableView, heightForRowAtIndexPath: indexPath)
        let img = UIImageView.init(frame: CGRectMake(0, 0, screenSize().width, cellHeight))
        img.setImageWithUrl(imageLinks[indexPath.row], placeHolderImage: UIImage.init(named: "service-placeholder.jpg"))
        cell?.addSubview(img)
        
        return cell!
    }
}

//MARK: - table view delegate

extension ServicesViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 102.0 * screenSize().width/320.0
    }
}
