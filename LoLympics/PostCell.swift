//
//  PostCell.swift
//  LoLympics
//
//  Created by Dev1 on 12/2/15.
//  Copyright © 2015 FXoffice. All rights reserved.
//

import UIKit
import Parse

class PostCell: UITableViewCell {
    
    @IBOutlet weak var featuredImg: UIImageView!

    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var excerptLbl: UILabel!
    
    @IBOutlet weak var categoryLbl: BadgeViewStyle!
    
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var imageDescLbl: UILabel!
    
    @IBOutlet weak var commentCount: UILabel!
   
    @IBOutlet weak var commentIcon: UILabel!
    
    private var _post: Post?
    
    var post: Post? {
        return _post
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
        
    }
    
    override func drawRect(rect: CGRect) {
        featuredImg.clipsToBounds = true
    }


    func configureCell(post: Post, img: UIImage?) {
    
        self._post = post
        
        if let title = post.title where title != "" {
            self.titleLbl.text = title
        } else {
            self.titleLbl.hidden = true
        }
        
        if let excerpt = post.excerpt where excerpt != "" {
            self.excerptLbl.text = excerpt
        } else {
            self.excerptLbl.hidden = true
        }
        
        if let category = post.category where category != "" {
            self.categoryLbl.text = category
        } else {
            self.categoryLbl.hidden = true
        }
        
        if let imageDesc = post.imageDesc where imageDesc != "" {
            self.imageDescLbl.text = imageDesc
        } else {
            self.imageDescLbl.text = " "
        }
        
        if let date = post.date where date != "" {
        
            let Date:NSDateFormatter = NSDateFormatter()
            Date.dateFormat = "yyyy-MM-dd"
            self.dateLbl.text = Date.stringFromDate(date)
            
        }
        
        if post.featuredImg != nil {
           
            if img != nil {
                self.featuredImg.image = img
            } else {
            
                let featuredImage = post.featuredImg
                
                featuredImage!.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                    if (error == nil) {
                        let image = UIImage(data:imageData!)!
                        self.featuredImg.image = image
                        MainVC.imageCache.setObject(image, forKey: self.post!.featuredImg!)
                    }
                }
                
            }
            
        } else {
            self.featuredImg.hidden = true
        }
        
        let query = PFQuery(className:"Comment")
        let postObject = PFObject(withoutDataWithClassName:"Post", objectId:post.postKey)
        query.whereKey("post", equalTo: postObject)
        query.countObjectsInBackgroundWithBlock {
            (count: Int32, error: NSError?) -> Void in
            if error == nil {
                if count > 0 {
                    self.commentCount.text = "\(count)"
                    self.commentIcon.hidden = false
                } else {
                    self.commentCount.hidden = true
                    self.commentIcon.hidden = true
                }
            }
        }
    
    }

    @IBAction func postShareAction(sender: AnyObject) {
        
        var textToShare = ""
        
        if let title = post!.title where title != "" {
            textToShare = "\(post!.title!)"
        }
        
        
        if let myWebsite = NSURL(string: "http://www.lololympics.com/winning-isnt-everything/")
        {
            let objectsToShare = [textToShare, myWebsite]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            //New Excluded Activities Code
            activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList]
            //
            
           // self.presentViewController(activityVC, animated: true, completion: nil)
            UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(activityVC, animated: true, completion: nil)
        }
        
        
    }
    
    
}
