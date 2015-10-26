# GifListApp
Simple iOS client for service https://github.com/Giphy/GiphyAPI written on Swift 2.0

## Description

The application uses two endpoints from GiphyAPI:

Trending items: http://api.giphy.com/v1/gifs/trending (loading 50 items by default)

Search gifs: http://api.giphy.com/v1/gifs/search (loading 25 items by default)

## Installation

Steps:

1. Clone the project from this repository
2. Install [cocoapods](https://cocoapods.org/) if not installed
3. Xcode7 if not installed
4. Go to project folder and run 'pod install' cocoapods command
5. Open project workspace and build GifListApp target
6. Enjoy the gifs!

## Third-party

[Alamofire](https://github.com/Alamofire/Alamofire) - for making requests

[SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) - for parsing server responses

[SDWebImage] (https://github.com/rs/SDWebImage) - loading and showing the gifs

[RxSwift] (https://github.com/ReactiveX/RxSwift) - used for performing search requests (TODO: add more reactive code. For example, found Alomofire extensions https://github.com/ararog/Alamofire-RACExtensions and https://github.com/indragiek/AlamofireRACExtensions)