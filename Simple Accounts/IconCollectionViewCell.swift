//
//  IconCollectionViewCell.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 01/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

class IconCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override var selected: Bool {
        didSet {
            backgroundColor = selected ? UIColor.grayColor() : UIColor.clearColor()
        }
    }
}