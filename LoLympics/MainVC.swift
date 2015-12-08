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
    var range = Range<Int>(start: 0, end: 2)
    var refreshControl:UIRefreshControl!
    var loadMoreStatus = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
       
        posts = []
        self.parseDataFromParse()
        

    }
    
    func parseDataFromParse() {
        
        let predicate = NSPredicate(format: "published = 1")
        let PostsQuery: PFQuery =  PFQuery(className:"Post", predicate: predicate)
        PostsQuery.addAscendingOrder("priority")
        //PostsQuery.limit = 2
        PostsQuery.skip = range.startIndex
        
        PostsQuery.limit = range.endIndex - range.startIndex
        
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
    
    func refresh(sender:AnyObject) {
        refreshBegin("Refresh",
            refreshEnd: {(x:Int) -> () in
                self.refreshControl.endRefreshing()
        })
    }
    
    func refreshBegin(newtext:String, refreshEnd:(Int) -> ()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            dispatch_async(dispatch_get_main_queue()) {
                self.posts = []
                self.parseDataFromParse()
                self.tableView.reloadData()
            }
            sleep(2)
            
            dispatch_async(dispatch_get_main_queue()) {
                refreshEnd(0)
            }
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset
        
        if deltaOffset <= 0 {
            loadMore()
        }
    }
    
    func loadMore() {
        if ( !loadMoreStatus ) {
            self.loadMoreStatus = true
            loadMoreBegin("Load more",
                loadMoreEnd: {(x:Int) -> () in
                    self.tableView.reloadData()
                    self.loadMoreStatus = false
            })
        }
    }
    
    func loadMoreBegin(newtext:String, loadMoreEnd:(Int) -> ()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            dispatch_async(dispatch_get_main_queue()) {
                
                
                self.parseDataFromParse()
            }
            sleep(2)
            
            dispatch_async(dispatch_get_main_queue()) {
                loadMoreEnd(0)
            }
        }
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
            
            let tap = UITapGestureRecognizer(target: self, action: "showImageViewer:")
            cell.featuredImg.addGestureRecognizer(tap)
            cell.featuredImg.tag = indexPath.row
            
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
    
    func showImageViewer(sender:AnyObject) {
        let id = sender.view!.tag
        let post = self.posts[id]
        performSegueWithIdentifier("ViewerVC", sender: post)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let post = self.posts[indexPath.row]
        
        performSegueWithIdentifier("DetailVC", sender: post)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailVC" {
            if let detailVC = segue.destinationViewController as? DetailVC {
                if let post = sender as? Post {
                    detailVC.post = post
                }
            }
        }
        if segue.identifier == "ViewerVC" {
            if let viewerVC = segue.destinationViewController as? ViewerVC {
                if let post = sender as? Post {
                    viewerVC.post = post
                }
            }
        }
    }
    
    
}
