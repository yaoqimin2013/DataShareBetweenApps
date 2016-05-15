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
    
    
}




