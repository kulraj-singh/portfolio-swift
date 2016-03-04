//
//  ContentModel.swift
//  portfolio
//
//  Created by iOS Developer on 03/03/16.
//  Copyright © 2016 Xperts Infosoft. All rights reserved.
//

import UIKit

class ContentModel: BaseModel {
    
    var header = ""
    var paragraphs = [AnyObject]()
    var backgroundColor = UIColor.whiteColor()
    
    override internal init() {
        super.init()
    }
}
