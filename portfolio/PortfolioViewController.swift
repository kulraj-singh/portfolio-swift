//
//  PortfolioViewController.swift
//  portfolio
//
//  Created by Kulraj Singh on 01/01/16.
//  Copyright © 2016 Xperts Infosoft. All rights reserved.
//

import UIKit
import Alamofire

class PortfolioViewController: BaseViewController {
    
    //MARK: - vc life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sendDataToServerWithTask(taskType: AFManager.TaskType) {
        
        switch taskType {
        case .TaskPortfolioList:
            let url = baseUrl + "portfolio"
            Alamofire.request(.POST, url).responseJSON(completionHandler: <#T##Response<AnyObject, NSError> -> Void#>)
            
        }
    }
    

//    
//    - (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//    
//    _requestManager = [[AFConnectionManager alloc]init];
//    _requestManager.delegate = self;
//    _appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
//    [self sendDataToServerWithTask:TASK_PORTFOLIO_LIST];
//    
//    [self.viewCall addTapRecognizerWithTarget:self selector:@selector(callClicked:)];
//    [_collApps registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
//    }
//    
//    - (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//    }
//    
//    #pragma mark - collection view data source
//    
//    - (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//    {
//    return _apps.count;
//    }
//    
//    - (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//    {
//    NSString *identifier = @"cellId";
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
//    for (UIView *subview in cell.subviews) {
//    [subview removeFromSuperview];
//    }
//    
//    int cellWidth = cell.frame.size.width;
//    int margin = 5;
//    int imgWidth = cellWidth - 2 * margin;
//    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(margin, 0, imgWidth, imgWidth)];
//    
//    AppModel *app = _apps[indexPath.row];
//    [img roundCornersWithRadius:10 borderColor:[UIColor clearColor] borderWidth:1];
//    [img setImageWithURL:[NSURL URLWithString:app.thumbnail] placeholderImage:[UIImage imageNamed:@"logo_512X512"]];
//    [cell addSubview:img];
//    
//    //image name
//    UILabel *lblName = [[UILabel alloc]initWithFrame:CGRectMake(margin, imgWidth + margin, imgWidth, nameLabelSize - margin)];
//    lblName.text = app.name;
//    lblName.textColor = [UIColor blackColor];
//    lblName.numberOfLines = 0;
//    lblName.font = [UIFont systemFontOfSize:14];
//    lblName.textAlignment = NSTextAlignmentCenter;
//    [cell addSubview:lblName];
//    
//    return cell;
//    }
//    
//    #pragma mark - collection view delegate flow layout
//    
//    - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//    {
//    int width = screenSize.width/3;
//    return CGSizeMake(width, width + nameLabelSize);
//    }
//    
//    #pragma mark - collection view delegate
//    
//    - (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//    {
//    PortfolioDetailViewController *portfolioDetailVc = [[PortfolioDetailViewController alloc]initWithNibName:@"PortfolioDetailViewController" bundle:nil];
//    portfolioDetailVc.selectedIndex = indexPath.row;
//    portfolioDetailVc.apps = _apps;
//    [self.navigationController pushViewController:portfolioDetailVc animated:YES];
//    }
//    
//    #pragma mark - send data to server
//    
//    - (void)sendDataToServerWithTask:(NSInteger)task
//    {
//    [self showLoader];
//    
//    NSMutableDictionary *postDict = [[NSMutableDictionary alloc]init];
//    switch (task) {
//    case TASK_PORTFOLIO_LIST:
//    {
//    [_requestManager callServiceWithRequestType:TASK_PORTFOLIO_LIST method:METHOD_GET params:postDict urlEndPoint:@"portfolio"];
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
//    case TASK_PORTFOLIO_LIST:
//    {
//    _apps = [[NSMutableArray alloc]init];
//    NSArray *portfolios = [responseDict objectForKey:@"portFolioList"];
//    for (NSDictionary *portfolioDict in portfolios) {
//    AppModel *app = [[AppModel alloc]initWithResponse:portfolioDict];
//    [_apps addObject:app];
//    }
//    [_collApps reloadData];
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
//    
//    @end


}
