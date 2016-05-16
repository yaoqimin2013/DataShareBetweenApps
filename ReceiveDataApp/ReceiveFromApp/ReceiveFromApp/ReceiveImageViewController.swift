//
//  ViewController.swift
//  ReceiveFromApp
//
//  Created by Qimin Yao on 5/12/16.
//  Copyright © 2016 Qimin Yao. All rights reserved.
//

import UIKit

class ReceiveImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subscribeNotificationCenter()
    
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        desubscribeFromNotificationCenter()
    }
    
    func subscribeNotificationCenter() {
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(loadImageData),
            name: receivedDataNotification,
            object: nil)
    }
    
    func desubscribeFromNotificationCenter() {
        NSNotificationCenter.defaultCenter().removeObserver(
            self,
            name: receivedDataNotification,
            object: nil)
    }
    
    func loadImageData(notification: NSNotification) {
        let dict = notification.object as! NSDictionary
        let JSONSavedPath = dict["filePath"] as? String
//        let fileManager = NSFileManager.defaultManager()
        if let path = JSONSavedPath {
            let saveurl = NSURL(string:path)
            let JSONData = NSData(contentsOfURL: saveurl!)
            if let data = JSONData {
                do {
                    let imageInfos = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSArray
                    print(imageInfos)
                } catch {
                    print("Failed to get images")
                }
            }
        } else {
            print("No file is found")
        }
    }
    
//    func loadImageData(notification: NSNotification) {
//        let dict = notification.object as! NSDictionary
//        let JSONSavedPath = dict["filePath"] as? String
//        let fileManager = NSFileManager.defaultManager()
//        if let path = JSONSavedPath {
//            let saveurl = NSURL(string:path)
//            let imageData = NSData(contentsOfURL: saveurl!)
//            if let imgData = imageData {
//                imageView.image = UIImage(data: imgData)
//                try! fileManager.removeItemAtURL(saveurl!)
//            }
//        } else {
//            print("No file is found")
//        }
//    }
    
}

