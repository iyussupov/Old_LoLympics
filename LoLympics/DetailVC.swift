//
//  DetailVC.swift
//  LoLympics
//
//  Created by Ingwar on 12/6/15.
//  Copyright © 2015 FXoffice. All rights reserved.
//

import UIKit
import Parse

let offset_HeaderStop:CGFloat = 243.0 // At this offset the Header stops its transformations

class DetailVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var contentField: UILabel!
    
    
    var post: Post!
    var comments = [Comment]()
    static var imageCache = NSCache()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerImage: UIImageView!
    
    @IBOutlet weak var categoryLbl: BadgeViewStyle!
    @IBOutlet weak var backBtnLbl: RoundBtnViewStyle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 90.0
        
        let CommentsQuery: PFQuery =  PFQuery(className:"Comment")
        CommentsQuery.whereKey("post", equalTo: PFObject(withoutDataWithClassName: "Post", objectId: self.post.postKey))
        CommentsQuery.addAscendingOrder("createdAt")
        
        comments = []
        
        CommentsQuery.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                for object in objects! {
                    
                    let date = object.createdAt as NSDate!
                    let comment = Comment(date: date, dictionary: object)
                    self.comments.append(comment)
                    
                }
                
                self.tableView.reloadData()
            }
            
            
        }
        
        self.updateUI()
    }
    
    func updateUI() {
    
        let Date:NSDateFormatter = NSDateFormatter()
        Date.dateFormat = "yyyy-MM-dd"
        postDate.text = Date.stringFromDate(post.date!)
        
        titleLbl.text = post.title
        contentField.text = post.content
    
        var img: UIImage?
        
        if let url = post.featuredImg {
            
            img = DetailVC.imageCache.objectForKey(url) as? UIImage
            
            if img != nil {
                self.headerImage.image = img
            } else {
                
                let featuredImage = post.featuredImg
                
                featuredImage!.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                    if (error == nil) {
                        let image = UIImage(data:imageData!)!
                        self.headerImage.image = image
                        DetailVC.imageCache.setObject(image, forKey: self.post!.featuredImg!)
                    }
                }
                
            }
            
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        headerImage.clipsToBounds = true
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let comment = self.comments[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell") as? CommentCell {
            
         /*
            var img: UIImage?
            
            if let url = post.featuredImg {
                
                img = DetailVC.imageCache.objectForKey(url) as? UIImage
                
            }
        */
            
            cell.configureCommentCell(comment)
            
            return cell
        } else {
            return PostCell()
        }
        
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y
        var headerTransform = CATransform3DIdentity
        
        // PULL DOWN -----------------
        
        if offset < 0 {
            
            let headerScaleFactor:CGFloat = -(offset) / headerImage.bounds.height
            let headerSizevariation = ((headerImage.bounds.height * (1.0 + headerScaleFactor)) - headerImage.bounds.height)/2.0
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            
            headerImage.layer.transform = headerTransform
        }
            
            // SCROLL UP/DOWN ------------
            
        else {
            
            // Header -----------
            
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)
            
            categoryLbl.layer.transform = headerTransform
            backBtnLbl.layer.transform = headerTransform
        }
        
        // Apply Transformations
        
        headerImage.layer.transform = headerTransform
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sizeHeaderToFit()
    }
    
    func sizeHeaderToFit() {
        let headerView = tableView.tableHeaderView!
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        let height = headerView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        var frame = headerView.frame
        frame.size.height = height
        headerView.frame = frame
        
        tableView.tableHeaderView = headerView
    }
    
    @IBAction func DetailsBackBtn(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }


}
