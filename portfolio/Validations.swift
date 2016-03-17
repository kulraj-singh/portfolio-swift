//
//  Validations.swift
//  portfolio
//
//  Created by iOS Developer on 17/03/16.
//  Copyright © 2016 Xperts Infosoft. All rights reserved.
//

let patternForCountryCode = "^[+]\\d{1,4}$"
let patternForPrice = "^\\d+(\\.\\d{1,2})?$"
let patternForInteger = "^\\d*$"
let patternForZipCode = "^\\d{4,8}$"
let patternForName = "^[A-z]*$"
let patternForPlace = "^[A-z\\s]*$"
let patternAlnum = "^[A-z\\d]*$"
let patternForDate = "^dd/dd/dddd$"
let patternForEmail = "^(\\w[.]?)*\\w+[= ](\\w[.]?)*\\w+[.][a-z]{2,4}$"
let patternForPhoneNumber = "^[0-9]{5,10}$"
let patternForCategoryName = "^[\\w ]+$"
let patternForItemName = "^[\\w ]+$"
let patternForOfferName = "^[\\w ]+$"
let patternForEmployeeID = "^[\\w\\d]+$"

import Foundation

extension String {
    
    public func isValid(patternToMatch pattern: String, options: NSRegularExpressionOptions) -> Bool {
        do {
            let regex = try NSRegularExpression.init(pattern: pattern, options: options)
            let matches = regex.matchesInString(pattern, options: NSMatchingOptions.Anchored, range: NSMakeRange(0, self.characters.count))
            return matches.count > 0
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return false
    }
    
    public func isValid(patternToMatch pattern: String) -> Bool {
        return self.isValid(patternToMatch: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
    }
}