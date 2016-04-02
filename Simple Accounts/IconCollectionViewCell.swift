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
    
    func setImage(image: UIImage) {
        imageView.image = image
        imageView.highlightedImage = image.imageWithRenderingMode(.AlwaysTemplate)
    }
}