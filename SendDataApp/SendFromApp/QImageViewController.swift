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
        
        FileManager.sharedData.sendDataToSharedContainer()
    }
}
