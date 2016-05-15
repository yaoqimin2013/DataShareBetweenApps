//
//  ShareDataModel.swift
//  SendFromApp
//
//  Created by Qimin Yao on 5/15/16.
//  Copyright © 2016 Qimin Yao. All rights reserved.
//

import Foundation
import UIKit

enum imageExtension : String {
    case JPG = ".JPG"
    case PNG = ".png"
}

struct ImageInfo {
    let name: String
    let type: imageExtension
    let imageURL: NSURL
    let description: String?
    var savedFilePath: NSURL? = nil
}

class FileManager {
    static let sharedData = FileManager()
    
    var images: [ImageInfo] = [ImageInfo]()
    
    func loadImage(name: String, ext: imageExtension, description: String? = nil, savedFilePath: NSURL? = nil) {
        let imageURL = NSBundle.mainBundle().bundleURL.URLByAppendingPathComponent(name + ext.rawValue)
        let imageInfo = ImageInfo(name: name, type:ext, imageURL: imageURL, description: description, savedFilePath: savedFilePath)
        images.append(imageInfo)
    }
    
    func doesExist(toSendImage: ImageInfo) -> Bool {
        for image in images {
            if toSendImage.name == image.name {
                return true
            }
        }
        return false
    }
    
    func getImageURL(toSendImage: ImageInfo) -> NSURL? {
        for image in images {
            if image.name == toSendImage.name {
                return image.savedFilePath
            }
        }
        return nil
    }
    
    func getImage(imageInfo: ImageInfo?) -> UIImage? {
        if let url = imageInfo?.imageURL {
            let imageData = NSData(contentsOfURL: url)
            if let data = imageData {
                return UIImage(data: data)
            }
        }
        return nil
    }
    
    func getImageInfo(imageInfo: ImageInfo?) -> ImageInfo? {
        for info in images {
            if info.name == imageInfo?.name {
                return info
            }
        }
        return nil
    }
    
    func setSavePathWithURL(imageInfo: ImageInfo?, savePathURL : NSURL?) {
        var idx: Int = -1
        for (index, info) in images.enumerate() {
            if info.name == imageInfo?.name {
                idx = index
            }
        }
        if idx >= 0 {
            images.removeAtIndex(idx)
            loadImage((imageInfo?.name)!, ext: (imageInfo?.type)!, description: imageInfo?.description, savedFilePath: savePathURL)
        }
    }
}

