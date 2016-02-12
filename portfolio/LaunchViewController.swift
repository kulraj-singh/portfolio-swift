
//
//  LaunchViewController.swift
//  portfolio
//
//  Created by Kulraj Singh on 10/11/15.
//  Copyright © 2015 Xperts Infosoft. All rights reserved.
//

import UIKit
import AVFoundation

class LaunchViewController: BaseViewController {
    
    @IBOutlet var imgBg: UIImageView!
    @IBOutlet var imgLogo: UIImageView!
    var radians : Float = 0.0
    var audioPlayer : AVAudioPlayer = AVAudioPlayer.init()
    var pushed : Bool = false
    
    //MARK: vc life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let imageName = screenSize().height == 480 ? "splash_640X960.jpg" : "splash_640X1136.jpg"
        let image = UIImage.init(named: imageName)
        self.imgBg.image = image
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fadeLogo()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.animateToNewPosition()
        
        //audio
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            playSoundFile("guitar")
            performSelector("playSoundFile:", withObject: "welcome_xperts", afterDelay: 8)
        } catch let error as NSError {
            print("error in audio:" + error.localizedDescription)
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: sound and logo
    
    func fadeLogo() {
        if (navigationController?.topViewController == self) {
            UIView.animateWithDuration(1.5, animations: {
                self.imgLogo.alpha = self.imgLogo.alpha == 0 ? 1.0 : 0
                }, completion: { (value: Bool) in
                    let delay = self.imgLogo.alpha == 0 ? 1.0 : 0.0
                    self.performSelector("fadeLogo", withObject: nil, afterDelay: delay)
            })
        }
    }
    
    func playSoundFile(fileName : String) {
        let soundPath = NSBundle.mainBundle().pathForResource(fileName, ofType: "mp3")
        let soundUrl = NSURL.fileURLWithPath(soundPath!)
        
        //create audio player and initialize sound
        do {
            try audioPlayer = AVAudioPlayer.init(contentsOfURL: soundUrl)
            audioPlayer.play()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    //MARK: animation
    
    func animateToNewPosition() {
        //apply transform for the animation
        let amplitude = Float(0.15)
        let scale = CGFloat(amplitude * (1.0 - cos(radians)) + 1.0)
        let scaleTransform = CGAffineTransformMakeScale(scale, scale)
        
        let bgsize = self.imgBg.frame.size
        let translateX = (bgsize.width - screenSize().width)/2 * CGFloat(cos(self.radians))
        let translateY = (bgsize.height - screenSize().height)/3 * CGFloat(0.6) + sin(CGFloat(self.radians))
        //combine scaling and translation
        let translateTransform = CGAffineTransformMakeTranslation(translateX, translateY)
        self.imgBg.transform = CGAffineTransformConcat(scaleTransform, translateTransform)
        self.radians += 0.007
        
        //push vc after some time
        let interval = Float(0.004)
        let time = self.radians * interval/0.007
        if (time > 8 && !self.pushed) {
            self.animateToHome()
        } else {
            self.performSelector("animateToNewPosition", withObject: nil, afterDelay: Double(interval))
        }
    }
    
    func animateToHome() {
        self.pushed = true
        let homeVc = HomeViewController.init(nibName: "HomeViewController", bundle: nil)
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.transitionWithView((self.navigationController?.view)!, duration: 0.5, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
                self.navigationController?.pushViewController(homeVc, animated: false)
            }, completion: nil)
        UIView.commitAnimations()
    }
}
