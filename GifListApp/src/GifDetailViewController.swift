//
//  GifDetailViewController.swift
//  GifListApp
//
//  Created by Eugene Shumilov on 10/26/15.
//  Copyright © 2015 Qulix Systems. All rights reserved.
//

import UIKit
import SDWebImage
import MessageUI

class GifDetailViewController: UIViewController {
    
    var gif: GifDescription?
    private lazy var imageView = UIImageView()
    private lazy var copyButton = UIButton()
    private lazy var smsButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        let views = ["imageView": imageView, "copyButton": copyButton, "smsButton": smsButton]
        
        imageView.contentMode = .ScaleAspectFit
        imageView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        copyButton.setTitle("Copy To Clipboard", forState: .Normal)
        copyButton.addTarget(self, action: "handleCopyButtonClick:", forControlEvents: .TouchUpInside)
        copyButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        copyButton.setTitleColor(UIColor.blueColor(), forState: .Highlighted)
        copyButton.backgroundColor = UIColor.grayColor()
        self.view.addSubview(copyButton)
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        
        smsButton.setTitle("Share via SMS", forState: .Normal)
        smsButton.addTarget(self, action: "handleSMSButtonClick:", forControlEvents: .TouchUpInside)
        smsButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        smsButton.setTitleColor(UIColor.blueColor(), forState: .Highlighted)
        smsButton.backgroundColor = UIColor.grayColor()
        self.view.addSubview(smsButton)
        smsButton.translatesAutoresizingMaskIntoConstraints = false
        
        let metrics = ["buttonTopOffset": 60, "space1": 20, "space2": 10, "buttonWidth": 170, "buttonHeight": 20,]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-buttonTopOffset-[copyButton(==buttonHeight)]-space2-[imageView]-space1-|", options: .AlignAllLeft, metrics: metrics, views: views))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[smsButton(==buttonHeight)]", options: .AlignAllLeft, metrics: metrics, views: views))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-space1-[imageView]-space1-|", options: .AlignAllLeft, metrics: metrics, views: views))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[copyButton(==buttonWidth)]-[smsButton(==buttonWidth)]", options: .AlignAllLastBaseline, metrics: metrics, views: views))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
        
        if let gif = self.gif {
            if let url = gif.bigUrl {
                imageView.sd_setImageWithURL(url)
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    
    @IBAction private func handleCopyButtonClick(sender: UIButton?) {
        if let gif = self.gif {
            UIPasteboard.generalPasteboard().string = gif.bigUrl?.absoluteString
        }
    }
    
    @IBAction private func handleSMSButtonClick(sender: UIButton?) {
        if let gif = self.gif {
            openMessageControllerWithText(gif.bigUrl?.absoluteString)
        }
    }
    
    // MARK: SMS
    
    func openMessageControllerWithText(text: String?) {
        if (MFMessageComposeViewController.canSendText()) {
            let messageComposeViewController = MFMessageComposeViewController()
            messageComposeViewController.body = text
            self.presentViewController(messageComposeViewController, animated: true, completion: nil)
        }
    }
    
}
