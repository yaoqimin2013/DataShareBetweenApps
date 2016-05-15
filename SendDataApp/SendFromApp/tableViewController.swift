//
//  tableViewController.swift
//  SendFromApp
//
//  Created by Qimin Yao on 5/12/16.
//  Copyright © 2016 Qimin Yao. All rights reserved.
//

import UIKit

enum imageExtension : String {
    case JPG = ".JPG"
    case PNG = ".png"
}

struct ImageInfo {
    let name: String
    let imageURL: NSURL
    let savedFilePath: NSURL? = nil
}

class tableViewController: UITableViewController {
    
    var imagesInfo = [ImageInfo]()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        print("TableViewController is loaded")
        
        loadData()

        super.viewDidLoad()
    }
    
    func loadData() {
        loadImage("image1", ext: .JPG)
        loadImage("image2", ext: .JPG)
    }
    
    func loadImage(name: String, ext: imageExtension) {
        let imageURL = NSBundle.mainBundle().bundleURL.URLByAppendingPathComponent(name + ext.rawValue)
        imagesInfo.append(ImageInfo(name: name, imageURL: imageURL))
    }
    
    // MARK: Data Source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesInfo.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    // MARK: Delegate
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        
        let imageData = NSData(contentsOfURL: imagesInfo[indexPath.row].imageURL)
        
        if let data = imageData {
            cell.imageView?.image = UIImage(data: data)
        }
        cell.textLabel?.text = imagesInfo[indexPath.row].name
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let imageVC = storyboard?.instantiateViewControllerWithIdentifier("QImageViewController") as! QImageViewController
        
        imageVC.imageURL = imagesInfo[indexPath.row].imageURL
        
        self.navigationController?.pushViewController(imageVC, animated: true)
    }
}
