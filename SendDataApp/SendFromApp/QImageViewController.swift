//
//  QImageViewController.swift
//  SendFromApp
//
//  Created by Qimin Yao on 5/12/16.
//  Copyright © 2016 Qimin Yao. All rights reserved.
//


import UIKit

class QImageViewController: UIViewController {

    var imageURL: NSURL? = nil
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {

        imageView.image = getImage(imageURL)
        
        super.viewDidLoad()
    }
    
    func getImage(imageURL: NSURL?) -> UIImage? {
        if let url = imageURL {
            let imageData = NSData(contentsOfURL: url)
            if let data = imageData {
                return UIImage(data: data)
            }
        }
        return nil
    }
    
    @IBAction func sendData(sender: AnyObject) {
        let image = getImage(imageURL)
        
        let fileManager = NSFileManager.defaultManager()
        if let containerURL = fileManager.containerURLForSecurityApplicationGroupIdentifier("group.datashare.extension"), let img = image {
            let imageFilePath = "image.JPG"
            let savePath = containerURL.URLByAppendingPathComponent("image.JPG")
            UIImageJPEGRepresentation(img, 1.0)?.writeToURL(savePath, atomically: true)
            let url = NSURL(string: "receiveApp://?SendApp&\(imageFilePath)")
            UIApplication.sharedApplication().openURL(url!)
        }
    }
}
