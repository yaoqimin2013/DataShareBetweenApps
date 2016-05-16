//
//  ViewController.swift
//  ReceiveFromApp
//
//  Created by Qimin Yao on 5/12/16.
//  Copyright © 2016 Qimin Yao. All rights reserved.
//

import UIKit

class ReceiveImageViewController: UICollectionViewController {
    
    var imageInfos : [[String: String]] = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.backgroundColor = UIColor.whiteColor()
        
        subscribeNotificationCenter()
    
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        desubscribeFromNotificationCenter()
    }
    
    // MARK: CollectionView Data source
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageInfos.count // hardcode
    }
    
    // Mark: CollectionView Delegate
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! ImageViewCell
        if imageInfos.count > 0 {
            let name = try! String(contentsOfFile: imageInfos[indexPath.row]["infoPath"]!, encoding: NSUTF8StringEncoding)
            let imageData = NSData(contentsOfFile: imageInfos[indexPath.row]["imagePath"]!)
            
            cell.imageName.text = name
            cell.imageView.image = UIImage(data: imageData!)
        }
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Clicked: \(indexPath.row)")
    }
    
    // MARK: Observers
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
        if let path = JSONSavedPath {
            let saveurl = NSURL(string:path)
            let JSONData = NSData(contentsOfURL: saveurl!)
            if let data = JSONData {
                do {
                    imageInfos = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSArray as! [[String : String]]
                    collectionView?.reloadData()
                } catch {
                    print("Failed to get images")
                }
            }
        } else {
            print("No file is found")
        }
    }
}

