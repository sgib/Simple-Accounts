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
    
    let pngImageNames: [String]
    let jpgImageNames: [String]
    
    private init() {
        self.pngImageNames = ImageResourceLoader.pathsToFileNames(NSBundle.mainBundle().pathsForResourcesOfType("png", inDirectory: nil))
        self.jpgImageNames = ImageResourceLoader.pathsToFileNames(NSBundle.mainBundle().pathsForResourcesOfType("jpg", inDirectory: nil))
    }
    
    private static func pathsToFileNames(paths: [String]) -> [String] {
        return paths.map({ $0.componentsSeparatedByString("/").last! }).filter({ !$0.hasPrefix("AppIcon") && !$0.containsString("@") })
    }
}