//
//  GifListViewController.swift
//  GifListApp
//
//  Created by Eugene Shumilov on 10/25/15.
//  Copyright © 2015 Qulix Systems. All rights reserved.
//

import UIKit
import SDWebImage
import RxCocoa
import RxSwift

class GifListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    let cellID = "GifListCellID"
    let cellHeight: CGFloat = 110.0
    var staticGifs: [GifDescription] = []
    var foundGifs: [GifDescription] = []
    var loader: GifListLoader?
    
    private lazy var tableView = UITableView()
    private lazy var resultSearchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
        tableView.registerClass(GifListCell.self, forCellReuseIdentifier: cellID)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let views = ["tableView": tableView]
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[tableView]|", options: .AlignAllLeft, metrics: nil, views: views)
        self.view.addConstraints(verticalConstraints)
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("|[tableView]|", options: .AlignAllLeft, metrics: nil, views: views)
        self.view.addConstraints(horizontalConstraints)
        
        resultSearchController.searchBar.delegate = self
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.sizeToFit()
        tableView.tableHeaderView = resultSearchController.searchBar
        
        resultSearchController.searchBar.rx_text
            .subscribeNext { [unowned self] searchText in
                self.searchWithTerm(searchText)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        GifListLoader().getTrendingItems { (gifs: [GifDescription]) -> () in
            self.staticGifs = gifs
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        resultSearchController.active = false
    }
    
    private func activeGifsArray() -> [GifDescription] {
        if resultSearchController.active {
            return foundGifs
        }
        else {
            return staticGifs
        }
    }
    
    private func searchWithTerm(term: String) {
        let loader = GifListLoader()
        loader.searchItems(term, completion: { (gifs: [GifDescription]) -> () in
            if loader == self.loader {
                self.foundGifs = gifs
                self.tableView.reloadData()
            }
        })
        self.loader = loader
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailedScreen = GifDetailViewController()
        detailedScreen.gif = activeGifsArray()[indexPath.row]
        self.navigationController?.pushViewController(detailedScreen, animated: true)
    }
    
    // MARK: UITableViewDataSource

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeGifsArray().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell :GifListCell = tableView.dequeueReusableCellWithIdentifier(cellID) as! GifListCell
        
        if let url = activeGifsArray()[indexPath.row].smallUrl {
            cell.aimatedImageView.sd_cancelCurrentImageLoad()
            cell.aimatedImageView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "placeholder"))
        }
        return cell
    }
    
    // MARK: UISearchBarDelegate
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        resultSearchController.active = false
        foundGifs = []
        tableView.reloadData()
    }
    
}

