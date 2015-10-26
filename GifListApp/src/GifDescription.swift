//
//  GifDescription.swift
//  GifListApp
//
//  Created by Eugene Shumilov on 10/26/15.
//  Copyright © 2015 Qulix Systems. All rights reserved.
//

import UIKit

class GifDescription: NSObject {
    internal var smallUrl: NSURL?
    internal var bigUrl: NSURL?
    
    init(smallUrl: String?, bigUrl: String?) {
        super.init()
        
        if let smallUrlString = smallUrl {
            self.smallUrl = NSURL(string: smallUrlString)
        }
        
        if let bigUrlString = bigUrl {
            self.bigUrl = NSURL(string: bigUrlString)
        }
    }
}
