//
//  HomeViewController.swift
//  portfolio
//
//  Created by Kulraj Singh on 20/11/15.
//  Copyright © 2015 Xperts Infosoft. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet var viewLogo : UIView!
    @IBOutlet var imgArc : UIImageView!
    @IBOutlet var arcLeftMargin : NSLayoutConstraint!
    @IBOutlet var buttonLeftMargins : [NSLayoutConstraint]!
    @IBOutlet var portfolioTopMargin :  NSLayoutConstraint!
    @IBOutlet var aboutTopMargin : NSLayoutConstraint!
    @IBOutlet var buttonWidths : [NSLayoutConstraint]!
    @IBOutlet var buttonHeights : [NSLayoutConstraint]!
    @IBOutlet var buttons : [UIButton]!
    @IBOutlet var btnSound : UIButton!
    @IBOutlet var faqTopMargin : NSLayoutConstraint!
    @IBOutlet var viewBottom : UIView!
    var buttonsShown : Bool = false
    
    //MARK: view controller life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.viewLogo.addBottomShadeWithWidth(2, color: UIColor.lightGrayColor())
        self.viewBottom.addTapRecognizerWithTarget(self, action: "callClicked:")
        self.setInitialPositions()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (!self.buttonsShown) {
            self.performSelector("animateArc", withObject: nil, afterDelay: 0.5)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setInitialPositions() {
        let screenHeight = screenSize().height
        let imageName = screenHeight == 480 ? "arc_small" : "arc"
        let arc = UIImage.init(named: imageName)
        self.imgArc.image = arc
        let xOffset = arc?.size.width
        self.arcLeftMargin.constant = -xOffset!
        
        //position buttons
        for leftMargin in self.buttonLeftMargins {
            leftMargin.constant = -120
        }
        let arcHeight = arc?.size.height
        var buttonStartY = screenHeight/2 - arcHeight!/2 - 25
        if (screenHeight == 480) {
            buttonStartY += 5
        }
        
        self.portfolioTopMargin.constant = buttonStartY
        self.aboutTopMargin.constant = buttonStartY + arcHeight!/4 - 20
        if (screenHeight == 480) {
            self.aboutTopMargin.constant += 5
            self.faqTopMargin.constant = 230
            
            //smaller buttons for small screen
            for width in self.buttonWidths {
                width.constant = 50
            }
            for height in self.buttonHeights {
                height.constant = 50
            }
        }
    }
    
    //MARK: - animations
    
    func animateArc() {
        self.arcLeftMargin.constant = 0
        UIView.animateWithDuration(0.6, animations: {
            self.view.layoutIfNeeded()
            }, completion: { (value: Bool) in
                self.animateButtons()
                self.buttonsShown = true
        })
    }
    
    func animateButtons() {
        let leftMargins = [CGFloat](arrayLiteral: 122, 195, 220, 195, 122)
        for i in 0...4 {
            let leftMargin = self.buttonLeftMargins[i]
            let leftMarginConstant = leftMargins[i]
            leftMargin.constant = leftMarginConstant
            UIView.animateWithDuration(0.8, animations: {
                self.view.layoutIfNeeded()
            })
            
            //create the line also
            let btn = self.buttons[i]
            let imgline = UIImageView.init(image: UIImage.init(named: "line"))
            imgline.center = CGPointMake(-100, btn.center.y)
            self.view.addSubview(imgline)
            let offset = CGPointMake(leftMarginConstant + 50, 0)
            imgline.translateWithOffset(offset, duration: 0.8)
        }
    }
    
    //MARK: - button clicks
    
    @IBAction func portfolioClicked(sender: AnyObject) {
        let portFolioVc = PortfolioViewController.init(nibName: "PortfolioViewController", bundle: nil)
        self.navigationController?.pushViewController(portFolioVc, animated: true)
    }
    
    @IBAction func aboutClicked(sender: AnyObject) {
        
    }
    
    @IBAction func servicesClicked(sender: AnyObject) {
        
    }
    
    @IBAction func faqClicked(sender: AnyObject) {
        
    }
    
    @IBAction func contactClicked(sender: AnyObject) {
        
    }
    
    @IBAction func soundClicked(sender: AnyObject) {
        
    }
}

//#pragma mark - button click
//
//- (IBAction)portfolioClicked:(id)sender
//{
//    PortfolioViewController *portfolioVc = [[PortfolioViewController alloc]initWithNibName:@"PortfolioViewController" bundle:nil];
//    [self.navigationController pushViewController:portfolioVc animated:YES];
//    }
//    
//    - (IBAction)aboutClicked:(id)sender
//{
//    AboutUsViewController *aboutVc = [[AboutUsViewController alloc]initWithNibName:@"AboutUsViewController" bundle:nil];
//    [self.navigationController pushViewController:aboutVc animated:YES];
//    }
//    
//    - (IBAction)servicesClicked:(id)sender
//{
//    ServicesViewController *serviceVc = [[ServicesViewController alloc]initWithNibName:@"ServicesViewController" bundle:nil];
//    [self.navigationController pushViewController:serviceVc animated:YES];
//    }
//    
//    - (IBAction)faqClicked:(id)sender
//{
//    FaqViewController *faqVc = [[FaqViewController alloc]initWithNibName:@"FaqViewController" bundle:nil];
//    [self.navigationController pushViewController:faqVc animated:YES];
//    }
//    
//    - (IBAction)soundClicked:(UIButton*)btnSound
//{
//    btnSound.selected = !btnSound.selected;
//    }
//    
//    - (IBAction)contactClicked:(id)sender
//{
//    ContactUsViewController *contactUsVc = [[ContactUsViewController alloc]initWithNibName:@"ContactUsViewController" bundle:nil];
//    [self.navigationController pushViewController:contactUsVc animated:YES];
//}
