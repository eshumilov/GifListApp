//
//  GifListLoader.swift
//  GifListApp
//
//  Created by Eugene Shumilov on 10/25/15.
//  Copyright © 2015 Qulix Systems. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GifListLoader: NSObject {
    
    internal func getTrendingItems(completion: (([GifDescription]) -> ())?) {
        Alamofire.request(.GET, "http://api.giphy.com/v1/gifs/trending", parameters: ["api_key": "dc6zaTOxFJmzC", "limit": 50])
            .responseJSON { response in
                let gifs = self.getGifsFromData(response.data)
                if let completionClosure = completion {
                    completionClosure(gifs)
                }
        }
    }
    
    internal func searchItems(term: String, completion: (([GifDescription]) -> ())?) {
        Alamofire.request(.GET, "http://api.giphy.com/v1/stickers/search", parameters: ["api_key": "dc6zaTOxFJmzC", "q": term])
            .responseJSON { response in
                let gifs = self.getGifsFromData(response.data)
                if let completionClosure = completion {
                    completionClosure(gifs)
                }
        }
    }
    
    private func getGifsFromData(responseData: NSData?) -> [GifDescription] {
        var gifs = [GifDescription]()
        if let data = responseData {
            let json = JSON(data: data, options: .MutableContainers, error: nil)
            if let protoGifs = json["data"].array {
                for (subJson):(JSON) in protoGifs {
                    let gif = GifDescription(smallUrl: subJson["images","fixed_height_small","url"].string, bigUrl: subJson["images","fixed_height","url"].string)
                    gifs.append(gif)
                }
            }
        }
        return gifs
    }
    
}
