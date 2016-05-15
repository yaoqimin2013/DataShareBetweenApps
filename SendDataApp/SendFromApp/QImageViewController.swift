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

        imageView.image = getImage(imageInfo)
        
        super.viewDidLoad()
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
    
    @IBAction func sendData(sender: AnyObject) {
        
        // send data
        let image = getImage(imageInfo)
        let fileManager = NSFileManager.defaultManager()
        if let containerURL = fileManager.containerURLForSecurityApplicationGroupIdentifier("group.datashare.extension"), let img = image {
            let shareFolder = NSUUID().UUIDString
            let dirctoryURL = containerURL.URLByAppendingPathComponent(shareFolder, isDirectory: true)
            try! fileManager.createDirectoryAtURL(dirctoryURL, withIntermediateDirectories: false, attributes: nil)
            let imageFilePath = shareFolder + "/image.JPG"
            let savePath = dirctoryURL.URLByAppendingPathComponent("image.JPG")
            UIImageJPEGRepresentation(img, 1.0)?.writeToURL(savePath, atomically: true)
            let url = NSURL(string: "receiveApp://?SendApp&\(imageFilePath)")
            UIApplication.sharedApplication().openURL(url!)
        }
    }
}
