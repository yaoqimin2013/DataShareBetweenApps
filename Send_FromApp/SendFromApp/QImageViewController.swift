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
        if let url = imageURL {
            let imageData = NSData(contentsOfURL: url)
            if let data = imageData {
                imageView.image = UIImage(data: data)
            }
        }
        
        super.viewDidLoad()
    }
    
    
    @IBAction func sendData(sender: AnyObject) {
    
        let url = NSURL(string: "receiveApp://?SendApp&Thissapath")
        UIApplication.sharedApplication().openURL(url!)
    }
}
