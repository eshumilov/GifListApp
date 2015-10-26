//
//  GifDetailViewController.swift
//  GifListApp
//
//  Created by Eugene Shumilov on 10/26/15.
//  Copyright © 2015 Qulix Systems. All rights reserved.
//

import UIKit
import SDWebImage

class GifDetailViewController: UIViewController {
    
    var gif: GifDescription?
    private lazy var imageView = UIImageView()
    private lazy var copyButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        let views = ["imageView": imageView, "copyButton": copyButton]
        
        imageView.contentMode = .ScaleAspectFit
        imageView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        copyButton.setTitle("Copy To Clipboard", forState: .Normal)
        copyButton.addTarget(self, action: "handleButtonClick:", forControlEvents: .TouchUpInside)
        copyButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        copyButton.setTitleColor(UIColor.blueColor(), forState: .Highlighted)
        copyButton.backgroundColor = UIColor.grayColor()
        self.view.addSubview(copyButton)
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-60-[copyButton(==20)]-10-[imageView]-20-|", options: .AlignAllLeft, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-20-[imageView]-20-|", options: .AlignAllLeft, metrics: nil, views: views))

        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[copyButton(==180)]", options: .AlignAllLeft, metrics: nil, views: views))
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
    
    @IBAction private func handleButtonClick(sender: UIButton?) {
        if let gif = self.gif {
            UIPasteboard.generalPasteboard().string = gif.bigUrl?.absoluteString
        }
    }
    
}
