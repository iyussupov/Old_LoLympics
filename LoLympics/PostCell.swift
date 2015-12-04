//
//  PostCell.swift
//  LoLympics
//
//  Created by Dev1 on 12/2/15.
//  Copyright © 2015 FXoffice. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var featuredImg: UIImageView!

    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var excerptLbl: UILabel!
    
    @IBOutlet weak var categoryLbl: BadgeViewStyle!
    
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var imageDescLbl: UILabel!
    
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

    func configureCell(post: Post) {
    
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
            self.imageDescLbl.hidden = true
        }
    
    }

    
    
}
