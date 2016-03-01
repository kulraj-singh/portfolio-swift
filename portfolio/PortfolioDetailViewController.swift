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
    
    //MARK: vc life cycle
    
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
        self.playstoreWidth.constant = width
    }
    
    func addTapGesture() {
        
    }
    
    //MARK: call service
    
    func sendDataToServerWithTask(taskType: AFManager.TaskType) {
        
        self.showActivityIndicator(self.view)
        
        switch taskType {
        case .TaskGetAppDetails:
            let app = self.apps[self.selectedIndex]
            let postDict = Dictionary<String, AnyObject>
            
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
                self.collImages.reloadData()
            } else {
                print("error")
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
//    
//    #pragma mark - send data to server
//    
//    - (void)sendDataToServerWithTask:(NSInteger)task
//    {
//    [self showLoader];
//    
//    NSMutableDictionary *postDict = [[NSMutableDictionary alloc]init];
//    switch (task) {
//    case TASK_PORTFOLIO_DETAILS:
//    {
//    AppModel *app = _apps[_selectedIndex];
//    [postDict setObject:app.Id forKey:kId];
//    [_requestManager callServiceWithRequestType:TASK_PORTFOLIO_DETAILS method:METHOD_POST params:postDict urlEndPoint:@"portfolio-detail"];
//    break;
//    }
//    
//    default:
//    break;
//    }
//    }
//    
//    #pragma mark - connection manager delegate
//    
//    - (void)requestFinishedWithResponse:(id)response
//    {
//    [self removeLoader];
//    
//    NSInteger requestType = [[response objectForKey:kRequestType]integerValue];
//    NSDictionary *responseDict = [response objectForKey:kResponseObject];
//    BOOL success = [[responseDict objectForKey:kStatus]boolValue];
//    NSString *message = [responseDict objectForKey:kMessage];
//    
//    if (success) {
//    switch (requestType) {
//    case TASK_PORTFOLIO_DETAILS:
//    {
//    NSDictionary *portfolioDict = [responseDict objectForKey:@"portFolio"];
//    AppModel *app = [[AppModel alloc]initWithResponse:portfolioDict];
//    [_apps replaceObjectAtIndex:_selectedIndex withObject:app];
//    [self bindUiWithApp:app];
//    [_carousel reloadData];
//    break;
//    }
//    
//    default:
//    break;
//    }
//    } else {
//    kAlert(nil, message);
//    }
//    }
//    
//    - (void)requestFailedWithError:(NSMutableDictionary *)errorDict
//    {
//    [self removeLoader];
//    NSError *error = [errorDict objectForKey:kError];
//    NSInteger tag = [[errorDict objectForKey:kRequestType]integerValue];
//    [self showServiceFailAlertWithMessage:error.localizedDescription tag:tag];
//    }
//    
//    #pragma mark - gesture
//    
//    - (void)addTapGesture
//    {
//    [self.viewPlaystore addTapRecognizerWithTarget:self selector:@selector(playstoreClicked:)];
//    [self.viewItunes addTapRecognizerWithTarget:self selector:@selector(itunesClicked:)];
//    [self.viewCall addTapRecognizerWithTarget:self selector:@selector(callClicked:)];
//    }
//    
//    - (IBAction)playstoreClicked:(id)sender
//    {
//    AppModel *app = _apps[_selectedIndex];
//    NSURL *url = [NSURL URLWithString:app.playstore];
//    if ([[UIApplication sharedApplication] canOpenURL:url]) {
//    [[UIApplication sharedApplication]openURL:url];
//    } else {
//    kAlert(nil, @"cannot open playstore link");
//    }
//    }
//    
//    - (IBAction)itunesClicked:(id)sender
//    {
//    AppModel *app = _apps[_selectedIndex];
//    NSString *ituneUrl = app.itunes;
//    NSURL *url = [NSURL URLWithString:ituneUrl];
//    if ([[UIApplication sharedApplication] canOpenURL:url]) {
//    [[UIApplication sharedApplication]openURL:url];
//    } else {
//    kAlert(nil, @"cannot open itunes link");
//    }
//    }
//    
//    #pragma mark - icarousel data source
//    
//    - (NSInteger)numberOfItemsInCarousel:(iCarousel * __nonnull)carousel
//    {
//    AppModel *app = _apps[_selectedIndex];
//    return app.images.count;
//    }
//    
//    - (UIView*)carousel:(iCarousel * __nonnull)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view
//    {
//    if (!view) {
//    CGSize carouselSize = carousel.frame.size;
//    int width = carouselSize.width;
//    int height = carouselSize.height;
//    view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width * 0.7, height * 0.9)];
//    } else {
//    for (UIView *subview in view.subviews) {
//    [subview removeFromSuperview];
//    }
//    }
//    
//    CGSize viewSize = view.frame.size;
//    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewSize.width, viewSize.height)];
//    img.contentMode = UIViewContentModeScaleAspectFit;
//    AppModel *app = _apps[_selectedIndex];
//    NSString *url = app.images[index];
//    UIImage *placeholder = [UIImage imageNamed:@"vertical_placeholder.jpg"];
//    [img setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];
//    [view addSubview:img];
//    
//    return view;
//    }
//    
//    #pragma mark - icarousel delegate
//    
//    - (void)carouselCurrentItemIndexDidChange:(iCarousel * __nonnull)carousel
//    {
//    //change dots
//    _pageControl.currentPage = carousel.currentItemIndex;
//    }

}
