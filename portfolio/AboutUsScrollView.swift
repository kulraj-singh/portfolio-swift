//
//  AboutUsScrollView.swift
//  portfolio
//
//  Created by iOS Developer on 03/03/16.
//  Copyright © 2016 Xperts Infosoft. All rights reserved.
//

import UIKit

enum Cell: Int {
    case Thinking = 0
    case Team
    case AppIndustry
}

class AboutUsScrollView: UIScrollView {
    
    var cellType = Cell.Thinking
    
    @IBOutlet var lblHeader: UILabel!
    @IBOutlet var lblFirstPara: UILabel!
    @IBOutlet var lblSecondPara: UILabel!
    @IBOutlet var lblThirdPara: UILabel!
    @IBOutlet var lblFourthPara: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let height = self.lblFourthPara.frame.origin.y + lblFourthPara.frame.size.height + 20
        self.contentSize = CGSizeMake(0, height)
    }
    
    internal func bindContent(content: ContentModel) {
        
        let header = content.header
        let attributedHeader = NSMutableAttributedString.init(string: header)
        let words = header.componentsSeparatedByString(" ") 
        let firstWord = words[0] 
        let smallFont = UIFont.init(name: (self.lblHeader?.font?.fontName)!, size: 15)
        let range = NSMakeRange((firstWord.characters.count), header.characters.count - (firstWord.characters.count))
        attributedHeader.addAttribute(NSFontAttributeName, value: smallFont!, range: range)
        
        var firstPara = content.paragraphs[0] as! String
        firstPara = firstPara.stringByReplacingOccurrencesOfString("<br>", withString: "\n")
        self.lblFirstPara.text = firstPara
        self.lblSecondPara.text = content.paragraphs[1] as? String
        self.lblThirdPara.text = content.paragraphs[2] as? String
        self.lblHeader.text = header
        
        if (self.cellType == Cell.AppIndustry) {
            self.lblSecondPara.textColor = UIColor.yellowColor()
            self.lblHeader.textColor = UIColor.yellowColor()
            self.lblFourthPara.text = content.paragraphs[3] as? String
        } else {
            self.lblThirdPara.textAlignment = NSTextAlignment.Right
            self.lblFourthPara.text = ""
        }
    }
}
