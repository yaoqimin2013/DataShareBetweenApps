//
//  tableViewController.swift
//  SendFromApp
//
//  Created by Qimin Yao on 5/12/16.
//  Copyright © 2016 Qimin Yao. All rights reserved.
//

import UIKit

class tableViewController: UITableViewController {

    var images = [NSURL]()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        print("TableViewController is loaded")
        
        loadData()

        super.viewDidLoad()
    }
    
    func loadData() {
        let imageURL = NSBundle.mainBundle().bundleURL.URLByAppendingPathComponent("image.JPG")
        images.append(imageURL)
    }
    
    // MARK: Data Source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    // MARK: Delegate
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        
        let imageData = NSData(contentsOfURL: images[0])
        
        if let data = imageData {
            cell.imageView?.image = UIImage(data: data)
        }
        cell.textLabel?.text = "Image"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let imageVC = storyboard?.instantiateViewControllerWithIdentifier("QImageViewController") as! QImageViewController
        
        imageVC.imageURL = images[0]
        
        self.navigationController?.pushViewController(imageVC, animated: true)
    }
}
