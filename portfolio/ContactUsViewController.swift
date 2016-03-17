//
//  ContactUsViewController.swift
//  portfolio
//
//  Created by iOS Developer on 04/03/16.
//  Copyright © 2016 Xperts Infosoft. All rights reserved.
//

import UIKit
import Alamofire

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
    
    //MARK: - vc life cycle
    
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
    
    //MARK: - UI
    
    func setTextFields() {
        let borderColor = UIColor.init(white: 229.0/255.0, alpha: 1)
        let bgColor = UIColor.init(white: 245.0/255.0, alpha: 1)
        for subview in self.scroller.subviews {
            if let textField = subview as? UITextField {
                textField.borderStyle = UITextBorderStyle.None
                textField.drawBorderWithColor(borderColor, width: 1)
                textField.addLeftPadding(10)
                textField.backgroundColor = bgColor
                textField.addToolbar(target: self, doneSelector: Selector("doneClicked:"), nextSelector: Selector("nextClicked:"))
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
    
    //MARK: - gesture
    
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
    
    //MARK: - button click
    
    @IBAction func sendClicked(sender: AnyObject) {
        if self.isValidForm() {
            self.view.endEditing(true)
            self.sendDataToServerWithTask(.TaskContactUs)
        }
    }
    
    func isValidForm() -> Bool {
        let name = self.txtName.text
        let email = self.txtEmail.text
        let companyName = self.txtCompanyName.text
        let phone = self.txtPhone.text
        
        if name?.characters.count == 0 {
            self.alert("Please enter your name")
            return false
        }
        if email?.characters.count == 0 {
            self.alert("Please enter your email")
            return false
        }
        if companyName?.characters.count == 0 {
            self.alert("Please enter your company name")
            return false
        }
        if phone?.characters.count == 0 {
            self.alert("Please enter your phone")
            return false
        }
        if name?.isValid(patternToMatch: patternForName) == false {
            self.alert("Please enter a valid name")
            return false
        }
        if email?.isValid(patternToMatch: patternForEmail) == false {
            self.alert("Please enter a valid email")
            return false
        }
        if companyName?.isValid(patternToMatch: patternForCategoryName) == false {
            self.alert("Please enter a valid company name")
            return false
        }
        if phone?.isValid(patternToMatch: patternForPhoneNumber) == false {
            self.alert("Please enter a valid phone number")
            return false
        }
        
        var isDeviceSelected = false
        for imgCheckBox in self.checkboxImages {
            if (imgCheckBox.highlighted == true) {
                isDeviceSelected = true
            }
        }
        if isDeviceSelected == false {
            self.alert("Please select at least one app device")
            return false
        }
        if self.txtMessage.text.characters.count == 0 {
            self.alert("Please enter a message as well")
            return false
        }
        return true
    }
    
    //MARK: - call service
    
    func sendDataToServerWithTask(taskType: AFManager.TaskType) {
        
        self.showActivityIndicator(self.view)
        
        switch taskType {
        case .TaskContactUs:
            let url = baseUrl + "contact"
            var postDict = Dictionary<String, AnyObject>()
            postDict.updateValue(self.txtName.text!, forKey: "name")
            postDict.updateValue(self.txtEmail.text!, forKey: "email")
            postDict.updateValue(self.txtCompanyName.text!, forKey: "company_name")
            postDict.updateValue(self.txtPhone.text!, forKey: "phone")
            postDict.updateValue(self.txtBudget.text!, forKey: "app_budget")
            postDict.updateValue(self.txtUrgency.text!, forKey: "urgency_level")
            
            let platforms = ["iPhone", "Android", "Windows", "Blackberry"]
            var selectedPlatforms = [String]()
            for imgCheckbox in self.checkboxImages {
                if imgCheckbox.highlighted {
                    let index = self.checkboxImages.indexOf(imgCheckbox)!
                    selectedPlatforms.append(platforms[index])
                }
            }
            let platformTypes = selectedPlatforms.joinWithSeparator(",")
            postDict.updateValue(platformTypes, forKey: "app_type")
            postDict.updateValue(self.txtMessage.text, forKey: "message")
            
            Alamofire.request(.POST, url, parameters: postDict, encoding: ParameterEncoding.URL, headers: nil)
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
                case .TaskContactUs:
                    let message = responseDict["msg"] as! String
                    self.alert(nil, message: message, delegate: self, cancelButtonTitle: nil, otherButtonTitles: ["OK"], style: UIAlertControllerStyle.Alert, tag: Alert.ContactUs)
                    
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
    
    //MARK: - alert delegate
    
    override func alertButtonClicked(index: Int, tag: Alert) {
        switch tag {
        case .ContactUs:
            self.navigationController?.popToRootViewControllerAnimated(true)
            
        default:
            super.alertButtonClicked(index, tag: tag)
        }
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
        
        let lbl = view?.viewWithTag(1) as! UILabel
        
        switch pickerView {
            case self.pickerBudget:
                lbl.text = self.budgets[row]
                
            case self.pickerUrgency:
                lbl.text = self.urgencies[row]
                
            default:
                break
        }
        return view!
    }
    
    //MARK: - picker view delegate
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case self.pickerBudget:
            self.txtBudget.text = self.budgets[row]
            
        case self.pickerUrgency:
            self.txtUrgency.text = self.urgencies[row]
            
        default:
            break;
        }
    }
}

//MARK: - text field delegate

extension ContactUsViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func doneClicked(btnDone: UIButton) {
        self.selectCurrentPickerValue(tag: btnDone.tag)
        self.view.endEditing(true)
    }
    
    @IBAction func nextClicked(btnNext: UIButton) {
        self.selectCurrentPickerValue(tag: btnNext.tag)
        self.view.endEditing(true)
    }
    
    func selectCurrentPickerValue(tag tag: NSInteger) {
        if let textFieldTag = TextField(rawValue: tag) {
            switch textFieldTag {
            case TextField.Budget:
                let selectedBudgetIndex = self.pickerBudget.selectedRowInComponent(0)
                self.pickerView(self.pickerBudget, didSelectRow: selectedBudgetIndex, inComponent: 0)
                
            case TextField.Urgency:
                let selectedUrgencyIndex = self.pickerUrgency.selectedRowInComponent(0)
                self.pickerView(self.pickerUrgency, didSelectRow: selectedUrgencyIndex, inComponent: 0)
            }
        }
    }
}

//MARK: - text view delegate

extension ContactUsViewController : UITextViewDelegate {
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}



