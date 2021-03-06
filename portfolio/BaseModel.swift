//
//  BaseModel.swift
//  portfolio
//
//  Created by iOS Developer on 12/02/16.
//  Copyright © 2016 Xperts Infosoft. All rights reserved.
//

import UIKit

let kId = "id"
let kStatus = "status"
let kError = "error"

class BaseModel: NSObject {
    
    var Id : String = ""
    
    override internal init() {
        super.init()
    }
    
    internal init(response: AnyObject?) {
        super.init()
        if let responseDict = response as? NSDictionary {
            self.Id = self.checkNil(responseDict[kId] as? String)
        }
    }
    
    internal func checkNil(text: String?) -> String {
        if (text == nil || text?.characters.count == 0) {
            return ""
        }
        return text!
    }
    
    internal func checkInt(num: Int?) -> Int {
        if (num == nil) {
            return 0
        }
        return num!
    }
    
    internal func checkBool(bit: Bool?) -> Bool {
        if (bit == nil) {
            return false
        }
        return bit!
    }
}
