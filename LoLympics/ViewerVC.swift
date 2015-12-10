//
//  ViewerVC.swift
//  LoLympics
//
//  Created by Dev1 on 12/7/15.
//  Copyright © 2015 FXoffice. All rights reserved.
//

import UIKit

class ViewerVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
   
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imageDesc: UILabel!
    
    var post: Post!
    static var imageCache = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 6.0
        
        self.imageDesc.text = post.imageDesc
        
        var img: UIImage?
        
        if let url = post.featuredImg {
            
            img = ViewerVC.imageCache.objectForKey(url) as? UIImage
            
            if img != nil {
                imageView.image = img
            } else {
                
                let featuredImage = post.featuredImg
                
                featuredImage!.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                    if (error == nil) {
                        let image = UIImage(data:imageData!)!
                        self.imageView.image = image
                        ViewerVC.imageCache.setObject(image, forKey: self.post!.featuredImg!)
                    }
                }
                
            }
            
        }
        
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }

    @IBAction func closeViewerAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}


