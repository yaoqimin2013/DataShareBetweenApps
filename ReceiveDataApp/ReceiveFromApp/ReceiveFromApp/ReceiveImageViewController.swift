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
        let imageFilePath = dict["filePath"] as? String
        let fileManager = NSFileManager.defaultManager()
        if let path = imageFilePath {
            let saveurl = NSURL(string:path)
            let imageData = NSData(contentsOfURL: saveurl!)
            if let imgData = imageData {
                imageView.image = UIImage(data: imgData)
                try! fileManager.removeItemAtURL(saveurl!)
            }
        } else {
            print("No file is found")
        }
    }
    
}

