//
//  AppModel.swift
//  portfolio
//
//  Created by iOS Developer on 12/02/16.
//  Copyright © 2016 Xperts Infosoft. All rights reserved.
//

import UIKit

let kCreatedAt = "createdAt"
let kDescription = "description"
let kDuplicateKey = "duplicate_key"
let kItuneLink = "itune"
let kName = "name"
let kPlaystoreLink = "playstore"
let kThumbnailLink = "thumbnail"
let kImages = "images"
let kIsAvailableItune = "isAvaliableoniTune"
let kIsAvailablePlaystore = "isavailableonplaystore"

class AppModel: BaseModel {
    var thumbnailLink: String = ""
    var name: String = ""
    var duplicateKey = ""
    var itunesLink = ""
    var playstoreLink = ""
    var status = 1
    var desCription = ""
    var images = [String]()
    var isAvailableOnItunes = true
    var isAvailableOnPlaystore = true
    
    internal override init(response: AnyObject?) {
        super.init(response: response)
        if let responseDict = response as? NSDictionary {
            self.thumbnailLink = self.checkNil(responseDict[kThumbnailLink] as? String)
            self.desCription = self.checkNil(responseDict[kDescription] as? String)
            self.duplicateKey = self.checkNil(responseDict[kDuplicateKey] as? String)
            self.itunesLink = self.checkNil(responseDict[kItuneLink] as? String)
            self.name = self.checkNil(responseDict[kName] as? String)
            self.playstoreLink = self.checkNil(responseDict[playstoreLink] as? String)
            self.status = self.checkInt(responseDict[kStatus] as? Int)
            if let images = responseDict[kImages] as? [String] {
                for image in images {
                    self.images.append(image)
                }
            }
            self.isAvailableOnItunes = responseDict[kIsAvailableItune] as! Bool
            self.isAvailableOnPlaystore = responseDict[kIsAvailablePlaystore] as! Bool
        } else {
            print(response?.classForCoder)
        }
    }
}
