//
//  ContactUsViewController.swift
//  portfolio
//
//  Created by iOS Developer on 04/03/16.
//  Copyright © 2016 Xperts Infosoft. All rights reserved.
//

import UIKit

enum TextField: Int {
    case Budget = 5
    case Urgency
}

enum Device {
    case Iphone
    case Android
    case Windows
    case Blackberry
}

class ContactUsViewController: BaseViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let budgets = ["$6000-$100000", "$10000-$15000", "$15000-$20000", "$20000-$25000", "$25000-$30000", "$30000-$35000", "$35000-$40000", "$40000-$45000", "$45000-$50000", "$50000 and above"]
    let urgencies = ["One Week", "Two Weeks", "Three Weeks", "Four Weeks", "No Urgency"]
    
    let pickerBudget = UIPickerView()
    let pickerUrgency = UIPickerView()
    @IBOutlet var viewCall : UIView!
    @IBOutlet var scroller : UIScrollView!
    @IBOutlet var txtName : UITextField!
    @IBOutlet var txtEmail : UITextField!
    @IBOutlet var txtCompanyName : UITextField!
    @IBOutlet var txtPhone : UITextField!
    @IBOutlet var deviceViews : [UIView]!
    @IBOutlet var checkboxImages : [UIImageView]!
    @IBOutlet var txtBudget : UITextField!
    @IBOutlet var deviceViewWidths : [NSLayoutConstraint]!
    @IBOutlet var txtUrgency : UITextField!
    @IBOutlet var txtMessage : UITextView!
    @IBOutlet var btnSend : UIButton!
    @IBOutlet var lblContact : UILabel!
    
    //MARK: vc life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTapGesture()
        self.setTextFields()
        self.addScrollView()
        self.addUrgencyPicker()
        self.addBudgetPicker()
        for width in self.deviceViewWidths {
            width.constant = screenSize().width/2
        }
        self.btnSend.roundCornersWithRadius(7, borderColor: UIColor.clearColor(), borderWidth: 1)
        self.txtBudget.text = self.budgets[0]
        self.txtUrgency.text = self.urgencies[0]
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.scroller.contentSize = CGSizeMake(screenSize().width, self.btnSend.frame.origin.y + 50)
        self.lblContact.addBottomShadeWithWidth(1, color: UIColor.grayColor())
    }
    
    //MARK: UI
    
    func setTextFields() {
        let borderColor = UIColor.init(white: 229.0/255.0, alpha: 1)
        let bgColor = UIColor.init(white: 245.0/255.0, alpha: 1)
        for subview in self.scroller.subviews {
            if let textField = subview as? UITextField {
                textField.borderStyle = UITextBorderStyle.None
                textField.drawBorderWithColor(borderColor, width: 1)
                textField.addLeftPadding(10)
                textField.backgroundColor = bgColor
                textField.addToolbar(target: self, doneSelector: Selector(doneClicked()), nextSelector: Selector(nextClicked()))
            }
        }
        self.txtBudget.addRightImage("arrow_icon")
        self.txtUrgency.addRightImage("arrow_icon")
        self.txtMessage.backgroundColor = bgColor
        self.txtMessage.drawBorderWithColor(borderColor, width: 1)
    }
    
    func addScrollView() {
        let navHeight = 64 as CGFloat
        let bottomBarHeight = 44 as CGFloat
        self.scroller.frame = CGRectMake(0, navHeight, screenSize().width, screenSize().height - navHeight - bottomBarHeight)
        self.view.addSubview(self.scroller)
    }
    
    func addBudgetPicker() {
        self.pickerBudget.dataSource = self
        self.pickerBudget.delegate = self
        self.txtBudget.inputView = self.pickerBudget
    }
    
    func addUrgencyPicker() {
        self.pickerUrgency.dataSource = self
        self.pickerUrgency.delegate = self
        self.txtUrgency.inputView = self.pickerUrgency
    }
    
    //MARK: gesture
    
    func addTapGesture() {
        for deviceView in self.deviceViews {
            deviceView.addTapRecognizerWithTarget(self, action: Selector(deviceViewTapped(deviceView)))
        }
        self.viewCall.addTapRecognizerWithTarget(self, action: Selector(callClicked()))
    }
    
    @IBAction func deviceViewTapped(deviceView: UIView) {
        let index = self.deviceViews.indexOf(deviceView)!
        let imgCheckbox = self.checkboxImages[index]
        imgCheckbox.highlighted = !imgCheckbox.highlighted
    }
    
    //MARK: - picker view data source
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
            case self.pickerBudget:
                return self.budgets.count
                
            case self.pickerUrgency:
                return self.urgencies.count
                
            default:
                return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        if view == nil {
            let view = UIView.init(frame: CGRectMake(0, 0, screenSize().width, 30))
            
            //add label
            let lbl = UILabel.init(frame: view.frame)
            lbl.tag = 1
            lbl.textAlignment = NSTextAlignment.Center
            view.addSubview(lbl)
        }
        return view!
    }
}

extension ContactUsViewController : UITextFieldDelegate {
    
    func doneClicked() {
        
    }
    
    func nextClicked() {
        
    }
}


//    
//    - (UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
//{
//    if (!view) {
//        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenSize.width, 30)];
//        
//        //add label
//        UILabel *lbl = [[UILabel alloc]initWithFrame:view.frame];
//        lbl.tag = 1;
//        lbl.textAlignment = NSTextAlignmentCenter;
//        [view addSubview:lbl];
//    }
//    
//    UILabel *lbl = (UILabel*)[view viewWithTag:1];
//    
//    if (pickerView == _pickerBudget) {
//        lbl.text = budgets[row];
//    }
//    if (pickerView == _pickerUrgency) {
//        lbl.text = urgencies[row];
//    }
//    
//    return view;
//}
//
//#pragma mark - picker view delegate
//
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
//{
//    if (pickerView == _pickerBudget) {
//        _txtBudget.text = budgets[row];
//    }
//    if (pickerView == _pickerUrgency) {
//        _txtUrgency.text = urgencies[row];
//    }
//}
//
//#pragma mark - text field delegate
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    return YES;
//    }
//    
//    - (IBAction)doneClicked:(UIButton*)btnDone
//{
//    [self selectCurrentPickerValueWithTextfieldTag:btnDone.tag];
//    [self.view endEditing:YES];
//    }
//    
//    - (IBAction)nextClicked:(UIButton*)btnNext
//{
//    [self selectCurrentPickerValueWithTextfieldTag:btnNext.tag];
//    [_scroller focusNextTextField];
//    }
//    
//    - (void)selectCurrentPickerValueWithTextfieldTag:(NSInteger)tag
//{
//    if (tag == TEXTFIELD_BUDGET) {
//        NSInteger selectedBudgetIndex = [_pickerBudget selectedRowInComponent:0];
//        [self pickerView:_pickerBudget didSelectRow:selectedBudgetIndex inComponent:0];
//    }
//    if (tag == TEXTFIELD_URGENCY) {
//        NSInteger selectedUrgencyIndex = [_pickerUrgency selectedRowInComponent:0];
//        [self pickerView:_pickerUrgency didSelectRow:selectedUrgencyIndex inComponent:0];
//    }
//}
//
//#pragma mark - text view delegate
//
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}
//
//#pragma mark - button click
//
//- (IBAction)sendClicked:(id)sender
//{
//    if ([self isValidForm]) {
//        [self.view endEditing:YES];
//        [self sendDataToServerWithTask:TASK_CONTACT_US];
//    }
//    }
//    
//    - (BOOL)isValidForm
//        {
//            NSString *name = _txtName.text;
//            NSString *email = _txtEmail.text;
//            NSString *companyName = _txtCompanyName.text;
//            NSString *phone = _txtPhone.text;
//            
//            if (name.length == 0) {
//                kAlert(nil, @"Please enter your name");
//                return NO;
//            }
//            if (email.length == 0) {
//                kAlert(nil, @"Please enter your email");
//                return NO;
//            }
//            if (companyName.length == 0) {
//                kAlert(nil, @"Please enter your email");
//                return NO;
//            }
//            if (phone.length == 0) {
//                kAlert(nil, @"Please enter phone number");
//                return NO;
//            }
//            
//            if (![name isValidForPattern:patternForPlace]) {
//                kAlert(nil, @"Please enter a valid name");
//                return NO;
//            }
//            if (![email isValidForPattern:patternForEmail]) {
//                kAlert(nil, @"Please enter a valid email");
//                return NO;
//            }
//            if (![companyName isValidForPattern:patternForCategoryName]) {
//                kAlert(nil, @"Please enter valid company name");
//                return NO;
//            }
//            if (![phone isValidForPattern:patternForPhoneNumber]) {
//                kAlert(nil, @"Please enter a valid phone number");
//                return NO;
//            }
//            
//            BOOL deviceSelected = NO;
//            for (UIImageView *imageCheckbox in _checkboxImages) {
//                if (imageCheckbox.highlighted) {
//                    deviceSelected = YES;
//                }
//            }
//            if (!deviceSelected) {
//                kAlert(nil, @"Please select at least one device");
//                return NO;
//            }
//            
//            if (_txtMessage.text.length == 0) {
//                kAlert(nil, @"Please enter a message");
//                return NO;
//            }
//            return YES;
//}
//
//#pragma mark - send data to server
//
//- (void)sendDataToServerWithTask:(NSInteger)task
//{
//    [self showLoader];
//    
//    NSMutableDictionary *postDict = [[NSMutableDictionary alloc]init];
//    switch (task) {
//    case TASK_CONTACT_US:
//        {
//            [postDict setObject:_txtName.text forKey:@"name"];
//            [postDict setObject:_txtEmail.text forKey:@"email"];
//            [postDict setObject:_txtCompanyName.text forKey:@"company_name"];
//            [postDict setObject:_txtPhone.text forKey:@"phone"];
//            [postDict setObject:_txtBudget.text forKey:@"app_budget"];
//            [postDict setObject:_txtUrgency.text forKey:@"urgency_level"];
//            
//            NSArray *platforms = @[@"iPhone", @"Android", @"Windows", @"Blackberry"];
//            NSMutableArray *selectedPlatforms = [NSMutableArray array];
//            for (UIImageView *imgCheckbox in _checkboxImages) {
//                if (imgCheckbox.highlighted) {
//                    NSInteger index = [_checkboxImages indexOfObject:imgCheckbox];
//                    NSString *platform = platforms[index];
//                    [selectedPlatforms addObject:platform];
//                }
//            }
//            NSString *platformTypes = [selectedPlatforms componentsJoinedByString:@","];
//            [postDict setObject:platformTypes forKey:@"app_type"];
//            [postDict setObject:_txtMessage.text forKey:kMessage];
//            [_requestManager callServiceWithRequestType:TASK_CONTACT_US method:METHOD_POST params:postDict urlEndPoint:@"contact"];
//            break;
//        }
//        
//    default:
//        break;
//    }
//}
//
//#pragma mark - connection manager delegate
//
//- (void)requestFinishedWithResponse:(id)response
//{
//    [self removeLoader];
//    
//    NSInteger requestType = [[response objectForKey:kRequestType]integerValue];
//    NSDictionary *responseDict = [response objectForKey:kResponseObject];
//    BOOL success = [[responseDict objectForKey:kStatus]boolValue];
//    NSString *message = [responseDict objectForKey:@"msg"]; //msg = messenger of god
//    
//    if (success) {
//        switch (requestType) {
//        case TASK_CONTACT_US:
//            {
//                [self.navigationController popViewControllerAnimated:YES];
//                kAlert(nil, message);
//                break;
//            }
//        default:
//            break;
//        }
//    } else {
//        kAlert(nil, message);
//    }
//    }
//    
//    - (void)requestFailedWithError:(NSMutableDictionary *)errorDict
//{
//    [self removeLoader];
//    NSError *error = [errorDict objectForKey:kError];
//    NSInteger tag = [[errorDict objectForKey:kRequestType]integerValue];
//    [self showServiceFailAlertWithMessage:error.localizedDescription tag:tag];
//}

