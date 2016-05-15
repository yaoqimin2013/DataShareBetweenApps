//
//  tableViewController.swift
//  SendFromApp
//
//  Created by Qimin Yao on 5/12/16.
//  Copyright © 2016 Qimin Yao. All rights reserved.
//

import UIKit



class tableViewController: UITableViewController {
    
    var imagesInfo = [ImageInfo]()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        print("TableViewController is loaded")
        
        loadData()

        super.viewDidLoad()
    }
    
    func loadData() {
        FileManager.sharedData.loadImage("image1", ext: .JPG, description: "Test driving on Charlotte")
        FileManager.sharedData.loadImage("image2", ext: .JPG, description: "Photo with labmates")
    }
    
    // MARK: Data Source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FileManager.sharedData.images.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    // MARK: Delegate
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        
        let imageData = NSData(contentsOfURL: FileManager.sharedData.images[indexPath.row].imageURL)
        
        if let data = imageData {
            cell.imageView?.image = UIImage(data: data)
        }
        cell.textLabel?.text = FileManager.sharedData.images[indexPath.row].name
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let imageVC = storyboard?.instantiateViewControllerWithIdentifier("QImageViewController") as! QImageViewController
        
        imageVC.imageInfo = FileManager.sharedData.images[indexPath.row]
        
        self.navigationController?.pushViewController(imageVC, animated: true)
    }
}
