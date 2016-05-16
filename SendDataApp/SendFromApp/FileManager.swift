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
    var savedImagePath: NSURL? = nil
    var saveInformationpath: NSURL? = nil
}

class FileManager {
    static let sharedData = FileManager()
    
    var images: [ImageInfo] = [ImageInfo]()
    
    func loadImage(name: String, ext: imageExtension, description: String? = nil, savedFilePath: NSURL? = nil, savedInformationPath: NSURL? = nil) {
        let imageURL = NSBundle.mainBundle().bundleURL.URLByAppendingPathComponent(name + ext.rawValue)
        let imageInfo = ImageInfo(name: name, type:ext, imageURL: imageURL, description: description, savedImagePath: savedFilePath, saveInformationpath: savedInformationPath)
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
                return image.savedImagePath
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
    
    func setSavePathWithURL(imageInfo: ImageInfo?, saveImageURL : NSURL?, saveInfoURL: NSURL?) {
        var idx: Int = -1
        for (index, info) in images.enumerate() {
            if info.name == imageInfo?.name {
                idx = index
            }
        }
        if idx >= 0 {
            images.removeAtIndex(idx)
            loadImage((imageInfo?.name)!, ext: (imageInfo?.type)!, description: imageInfo?.description, savedFilePath: saveImageURL, savedInformationPath: saveInfoURL)
        }
    }
    
    func createJSON(infos: [ImageInfo]) -> NSData? {
        
        var toSendDataDict = [[String: String]]()
        
        for info in infos {
            if let imagePath = info.savedImagePath, let infoPath = info.saveInformationpath {
                let paths = ["imagePath" : imagePath.path!, "infoPath" : infoPath.path!]
                toSendDataDict.append(paths)
            }
        }
    
        if !toSendDataDict.isEmpty {
            do {
                 let JsonData = try NSJSONSerialization.dataWithJSONObject(toSendDataDict, options: .PrettyPrinted)
                return JsonData
            } catch let error as NSError {
                print("Create JSON failed: " + error.description)
            }
        }
        
        return nil
    }
    
    func sendDataToSharedContainer() {

        var sendURL: NSURL? = nil
        let fileManager = NSFileManager.defaultManager()
        if let containerURL = fileManager.containerURLForSecurityApplicationGroupIdentifier("group.datashare.extension") {

            let shareFolder = NSUUID().UUIDString
            let dirctoryURL = containerURL.URLByAppendingPathComponent(shareFolder, isDirectory: true)
            try! fileManager.createDirectoryAtURL(dirctoryURL, withIntermediateDirectories: false, attributes: nil)
            for imageInfo in images {
                let savedImageURL = dirctoryURL.URLByAppendingPathComponent(imageInfo.name)
                let savedInfoURL = dirctoryURL.URLByAppendingPathComponent("Info")
                setSavePathWithURL(imageInfo, saveImageURL: savedImageURL, saveInfoURL: savedInfoURL)
                
                UIImageJPEGRepresentation(getImage(imageInfo)!, 1.0)?.writeToURL(savedImageURL, atomically: true)
                let text = imageInfo.name
                try! text.writeToURL(savedInfoURL, atomically: true, encoding: NSUTF8StringEncoding)
            }
            
            let JsonData = createJSON(images)
            if let data = JsonData {
                let savedJsonURL = dirctoryURL.URLByAppendingPathComponent("JSON")
                try! data.writeToURL(savedJsonURL, options: .AtomicWrite)
                sendURL = NSURL(string: "receiveApp://?SendApp&\(savedJsonURL)")
            }
            
            if let url = sendURL {
                UIApplication.sharedApplication().openURL(url)
            }
        }
    }
}

