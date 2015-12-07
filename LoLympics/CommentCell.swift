//
//  CommentCell.swift
//  LoLympics
//
//  Created by Ingwar on 12/6/15.
//  Copyright © 2015 FXoffice. All rights reserved.
//

import UIKit
import Parse

class CommentCell: UITableViewCell {
    
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
        avatar.clipsToBounds = true
    }
    
    
    func configureCommentCell(comment: Comment) {
        self.textLbl.text = ""
        self.dateLbl.text = ""
        self.author.text = ""
        self.avatar.image = UIImage(named: "avatar")
        
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
                        
                        self.avatar.downloadedFrom(link: userAvatar as! String, contentMode: UIViewContentMode.ScaleAspectFill)
                        
                    }
                   
                }
            } else {
                print(error)
            }
        })
        
        
    }

}
