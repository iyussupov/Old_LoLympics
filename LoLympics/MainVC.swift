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
    
    
    var posts = [Post]()
    static var imageCache = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
        //tableView.allowsSelection = false
       
        let PostsQuery: PFQuery =  PFQuery(className:"Post")
        PostsQuery.addAscendingOrder("priority")
        //PostsQuery.limit = 1
        
        posts = []
        
        PostsQuery.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                for object in objects! {
                    
                    let key = object.objectId as String!
                    let date = object.createdAt as NSDate!
                    let post = Post(postKey: key, date: date, dictionary: object)
                    self.posts.append(post)
                    
                }
                
                self.tableView.reloadData()
            }
            
            
        }
        

    }

    override func viewDidAppear(animated: Bool) {
      
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let post = self.posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostCell {
            
            var img: UIImage?
            
            if let url = post.featuredImg {
            
                img = MainVC.imageCache.objectForKey(url) as? UIImage
                
            }
            
            cell.configureCell(post, img: img)
            
            return cell
        } else {
            return PostCell()
        }
        
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        let post = self.posts[indexPath.row]
        
        performSegueWithIdentifier("DetailsVC", sender: post)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailsVC" {
            if let detailsVC = segue.destinationViewController as? DetailsVC {
                if let post = sender as? Post {
                    detailsVC.post = post
                }
            }
        }
    }
    
    
}
