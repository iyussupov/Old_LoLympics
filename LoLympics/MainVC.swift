//
//  MainVC.swift
//  LoLympics
//
//  Created by Dev1 on 12/1/15.
//  Copyright © 2015 FXoffice. All rights reserved.
//

import UIKit
import Parse

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var Posts:NSMutableArray = NSMutableArray()
    
    func loadData() {
    
        
        let PostsQuery: PFQuery =  PFQuery(className:"Post")
        PostsQuery.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                for object in objects! {
                    
                    let ParseObject:PFObject = object
                    self.Posts.addObject(ParseObject)
                    
                }
                
                let Array:NSArray = self.Posts.reverseObjectEnumerator().allObjects
                self.Posts = NSMutableArray(array: Array)
                self.tableView.reloadData()
                
            }
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
        //tableView.allowsSelection = false
        

    }
    
    override func viewDidAppear(animated: Bool) {
        self.loadData()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // cell.selectionStyle = UITableViewCellSelectionStyle.None
        let cell:PostCell =  tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostCell
        let postObject:PFObject = self.Posts.objectAtIndex(indexPath.row) as! PFObject
        
        cell.titleLbl.text = postObject.objectForKey("title") as? String
        cell.excerptLbl.text = postObject.objectForKey("excerpt") as? String
        cell.categoryLbl.text = postObject.objectForKey("category") as? String
        cell.imageDescLbl.text = postObject.objectForKey("imageDesc") as? String
        
        let Date:NSDateFormatter = NSDateFormatter()
        Date.dateFormat = "yyyy-MM-dd"
        cell.dateLbl.text = Date.stringFromDate(postObject.createdAt!)
        
        let featuredImage = postObject.objectForKey("featuredImage") as! PFFile
        
        featuredImage.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
          if (error == nil) {
            let image = UIImage(data:imageData!)
            cell.featuredImg.image = image
         }
        }
            
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let post = indexPath.row
        print(post)
        
        performSegueWithIdentifier(SEGUE_DETAILS, sender: post)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SEGUE_DETAILS {
            if let detailsVC = segue.destinationViewController as? DetailsVC {
                if let post = sender {
                    detailsVC.passObject = post as! Int
                }
            }
        }
    }
    
    
}
