//
//  ShareDataModel.swift
//  SendFromApp
//
//  Created by Qimin Yao on 5/15/16.
//  Copyright © 2016 Qimin Yao. All rights reserved.
//

import Foundation

enum imageExtension : String {
    case JPG = ".JPG"
    case PNG = ".png"
}

struct ImageInfo {
    let name: String
    let imageURL: NSURL
    let description: String?
    let savedFilePath: NSURL? = nil
}

class FileManager {
    static let sharedData = FileManager()
    
    var images: [ImageInfo] = [ImageInfo]()
    
    func loadImage(name: String, ext: imageExtension, description: String?) {
        let imageURL = NSBundle.mainBundle().bundleURL.URLByAppendingPathComponent(name + ext.rawValue)
        if let message = description {
            images.append(ImageInfo(name: name, imageURL: imageURL, description: message))
        } else {
            images.append(ImageInfo(name: name, imageURL: imageURL, description: nil))
        }
    }
    
}