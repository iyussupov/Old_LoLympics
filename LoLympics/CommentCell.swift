//
//  CommentCell.swift
//  LoLympics
//
//  Created by Ingwar on 12/6/15.
//  Copyright © 2015 FXoffice. All rights reserved.
//

import UIKit
import Parse
import Alamofire

class CommentCell: UITableViewCell {
    
    var request: Request?
    
    @IBOutlet weak var textLbl: UILabel!
    
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var author: UILabel!
    
    @IBOutlet weak var avatar: UIImageView!
    
    private var _comment: Comment?
    
    var comment: Comment? {
        return _comment
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func drawRect(rect: CGRect) {
        //featuredImg.clipsToBounds = true
    }
    
    
    func configureCommentCell(comment: Comment, img: UIImage?) {
        
        self._comment = comment
        
        if let text = comment.text where text != "" {
            self.textLbl.text = text
        } else {
            self.textLbl.hidden = true
        }
        
        if let date = comment.date where date != "" {
            
            let Date:NSDateFormatter = NSDateFormatter()
            Date.dateFormat = "yyyy-MM-dd"
            self.dateLbl.text = Date.stringFromDate(date)
            
        }
        
        let userId = comment.author?.objectId as String!
        
        let query = PFUser.query()
        query?.whereKey("objectId", equalTo: userId)
        query?.findObjectsInBackgroundWithBlock({ (NSArray objects, NSError error) -> Void in
            if error == nil {
                for user in objects! {
                    
                    self.author.text = user["username"] as? String
                    
                    let userAvatar = user["avatar"]
                    
                    if userAvatar != nil {
                        //Use the cached image if there is one, otherwise download the image
                        if img != nil {
                            self.avatar.image = img!
                        } else {
                            //Must store the request so we can cancel it later if this cell is now out of the users view
                            request = Alamofire.request(.GET!, userAvatar!).validate(contentType: ["image/*"]).response(completionHandler: { request, response, data, err in
                                
                                if err == nil {
                                    let img = UIImage(data: data!)!
                                    self.avatar.image = img
                                    //DetailVC.imageCache.setObject(img, forKey: self.post!.imageUrl!)
                                }
                            })
                            
                        }
                        
                    } else {
                        self.avatar.hidden = true
                    }
                   
                    
                }
            } else {
                print(error)
            }
        })
        
        
    }

}
