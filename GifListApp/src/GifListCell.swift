//
//  GifListCell.swift
//  GifListApp
//
//  Created by Eugene Shumilov on 10/26/15.
//  Copyright © 2015 Qulix Systems. All rights reserved.
//

import UIKit

class GifListCell: UITableViewCell {
    
    internal lazy var aimatedImageView = UIImageView()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(aimatedImageView)
        aimatedImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["aimatedImageView": aimatedImageView]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-5-[aimatedImageView]-5-|", options: .AlignAllLeft, metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-5-[aimatedImageView(==80)]", options: .AlignAllLeft, metrics: nil, views: views))
    }
}
