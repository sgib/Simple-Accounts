//
//  ImageResourceLoader.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 01/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation
import UIKit

class ImageResourceLoader {
    static let sharedInstance = ImageResourceLoader()
    
    let pngImages: [UIImage]
    let jpgImages: [UIImage]
    
    private init() {
        let pngPaths = NSBundle.mainBundle().pathsForResourcesOfType("png", inDirectory: nil)
        self.pngImages = ImageResourceLoader.pathsToFileNames(pngPaths).map({ UIImage(named: $0)! })
        let jpgPaths = NSBundle.mainBundle().pathsForResourcesOfType("jpg", inDirectory: nil)
        self.jpgImages = ImageResourceLoader.pathsToFileNames(jpgPaths).map({ UIImage(named: $0)! })
    }
    
    private static func pathsToFileNames(paths: [String]) -> [String] {
        return paths.map({ $0.componentsSeparatedByString("/").last! }).filter({ !$0.hasPrefix("AppIcon") && !$0.containsString("@") })
    }
}