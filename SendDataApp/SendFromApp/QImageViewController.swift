//
//  QImageViewController.swift
//  SendFromApp
//
//  Created by Qimin Yao on 5/12/16.
//  Copyright © 2016 Qimin Yao. All rights reserved.
//


import UIKit

class QImageViewController: UIViewController {
    
    var imageInfo: ImageInfo? = nil
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {

        imageView.image = FileManager.sharedData.getImage(imageInfo)
        
        super.viewDidLoad()
    }
    
    @IBAction func sendData(sender: AnyObject) {
        
        // send data
        let image = FileManager.sharedData.getImage(imageInfo)
        var sendURL: NSURL? = nil
//        if let savedPathURL = FileManager.sharedData.getImageURL(imageInfo!) {
//            sendURL = NSURL(string: "receiveApp://?SendApp&\(savedPathURL)")
//        } else {
            let fileManager = NSFileManager.defaultManager()
            if let containerURL = fileManager.containerURLForSecurityApplicationGroupIdentifier("group.datashare.extension"), let img = image {
                let shareFolder = NSUUID().UUIDString
                let dirctoryURL = containerURL.URLByAppendingPathComponent(shareFolder, isDirectory: true)
                try! fileManager.createDirectoryAtURL(dirctoryURL, withIntermediateDirectories: false, attributes: nil)
                let savedPathURL = dirctoryURL.URLByAppendingPathComponent("image.JPG")
                
                // add url to fileManager
                FileManager.sharedData.setSavePathWithURL(imageInfo, savePathURL: savedPathURL)
                
                UIImageJPEGRepresentation(img, 1.0)?.writeToURL(savedPathURL, atomically: true)
                sendURL = NSURL(string: "receiveApp://?SendApp&\(savedPathURL)")
            }
//        }
        if let url = sendURL {
            UIApplication.sharedApplication().openURL(url)
        }
    }
}
