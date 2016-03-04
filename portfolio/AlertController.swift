//
//  AlertController.swift
//  portfolio
//
//  Created by iOS Developer on 02/03/16.
//  Copyright © 2016 Xperts Infosoft. All rights reserved.
//

import UIKit

protocol AlertControllerDelegate {
    func alertOkClicked(alertController: AlertController, buttonIndex: Int, tag: Int)
    func alertControllerCancelled()
}

class AlertController: NSObject {
    
    var delegate: AlertControllerDelegate?
    
//    class func alertWithMessage(message: String, presentingViewController: UIViewController) {
//        self.showAlertWithTitle(nil, message: message, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: ["OK"], style: .Alert, presentingViewController: presentingViewController, tag: 0)
//    }
//    
//    class func alertWithMessage(message: String, presentingViewController: UIViewController, tag: Int) {
//        self.showAlertWithTitle(nil, message: message, delegate: presentingViewController, cancelButtonTitle: nil, otherButtonTitles: ["OK"], style: .Alert, presentingViewController: presentingViewController, tag: tag)
//    }
//    
//    class func showAlertWithTitle(title: String?, message: String, delegate:AnyObject?, cancelButtonTitle: String?, otherButtonTitles: Array<String>?, style: UIAlertControllerStyle, presentingViewController: UIViewController, tag: Int) {
//        let alert = UIAlertController.init(title: title, message: message, preferredStyle: style)
//        if (cancelButtonTitle != nil) {
//            let cancelAction = UIAlertAction.init(title: cancelButtonTitle, style: UIAlertActionStyle.Cancel, handler: {
//                _ in
//                alert.dismissViewControllerAnimated(true, completion: nil)
//                delegate?.performSelector(Selector(alertControllerCancelled()), withObject: nil)
//            })
//        }
//    }
    
}
    
//    + (void)alertWithMessage:(NSString*)message presentingViewController:(UIViewController*)vc
//    {
//    [self showAlertWithTitle:nil message:message delegate:vc cancelButtonTitle:nil otherButtonTitles:@[@"OK"] style:UIAlertControllerStyleAlert presentingViewController:vc tag:0];
//    }
//    
//    + (void)alertWithMessage:(NSString *)message presentingViewController:(UIViewController *)vc tag:(NSInteger)tag
//    {
//    [self showAlertWithTitle:nil message:message delegate:vc cancelButtonTitle:nil otherButtonTitles:@[@"OK"] style:UIAlertControllerStyleAlert presentingViewController:vc tag:tag];
//    }
//    
//    + (void)showAlertWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelTitle otherButtonTitles:(NSArray *)otherButtonTitles style:(UIAlertControllerStyle)style presentingViewController:(UIViewController *)vc tag:(NSInteger)tag
//    {
//    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
//    
//    if (cancelTitle) {
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * action)
//    {
//    [alert dismissViewControllerAnimated:YES completion:nil];
//    if ([delegate respondsToSelector:@selector(alertControllerDidCancel)]) {
//    [delegate alertControllerDidCancel];
//    }
//    }];
//    [alert addAction:cancel];
//    }
//    
//    for (NSString *buttonTitle in otherButtonTitles) {
//    UIAlertAction* ok = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
//    {
//    [alert dismissViewControllerAnimated:YES completion:nil];
//    if ([delegate respondsToSelector:@selector(alertController:clickedButtonAtIndex:tag:)]) {
//    NSInteger buttonIndex = [otherButtonTitles indexOfObject:buttonTitle];
//    [delegate alertController:alert clickedButtonAtIndex:buttonIndex tag:tag];
//    }
//    }];
//    [alert addAction:ok];
//    }
//    
//    [vc presentViewController:alert animated:YES completion:nil];
//    }
//    
//    - (void)showAlertWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelTitle otherButtonTitles:(NSArray *)otherButtonTitles presentingViewController:(UIViewController *)vc tag:(NSInteger)tag
//    {
//    self.uiAlertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
//    
//    if (cancelTitle) {
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * action)
//    {
//    [_uiAlertController dismissViewControllerAnimated:YES completion:nil];
//    if ([delegate respondsToSelector:@selector(alertControllerDidCancel)]) {
//    [delegate alertControllerDidCancel];
//    }
//    }];
//    [_uiAlertController addAction:cancel];
//    }
//    
//    for (NSString *buttonTitle in otherButtonTitles) {
//    UIAlertAction* ok = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
//    {
//    [_uiAlertController dismissViewControllerAnimated:YES completion:nil];
//    if ([delegate respondsToSelector:@selector(alertController:clickedButtonAtIndex:tag:)]) {
//    NSInteger buttonIndex = [otherButtonTitles indexOfObject:buttonTitle];
//    [delegate alertController:_uiAlertController clickedButtonAtIndex:buttonIndex tag:tag];
//    }
//    }];
//    [_uiAlertController addAction:ok];
//    }
//    
//    [vc presentViewController:_uiAlertController animated:YES completion:nil];
//    }
//    
//    #pragma mark - text field
//    
//    - (void)addTextFieldWithPlaceholder:(NSString *)placeholder
//    {
//    [self addTextFieldWithPlaceholder:placeholder secureEntry:NO];
//    }
//    
//    - (void)addTextFieldWithPlaceholder:(NSString *)placeholder secureEntry:(BOOL)secure
//    {
//    [self.uiAlertController addTextFieldWithConfigurationHandler:^(UITextField* tf) {
//    tf.placeholder = placeholder;
//    tf.secureTextEntry = secure;
//    }];
//    }
