//
//  RightSideVC.swift
//  LoLympics
//
//  Created by Dev1 on 12/11/15.
//  Copyright © 2015 FXoffice. All rights reserved.
//

import UIKit
import Parse

class RightSideVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var searchTableView: UITableView!
    
    var categories = [Category]()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
        //
        self.navigationController?.view.setNeedsLayout()
        //
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "contentSizeDidChangeNotification:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        //
        
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
        
        searchTableView.dataSource = self
        searchTableView.delegate = self
        
        loadCategoriesList()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        var rowsCount:Int = 0
        if tableView == self.categoryTableView {
            rowsCount = categories.count
        } else {
        
        }
        
        return rowsCount
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 48.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell
        
        if tableView == self.categoryTableView {
            
            if let cell = categoryTableView.dequeueReusableCellWithIdentifier("CategoryCell") as? CategoryCell {
                
                let category = self.categories[indexPath.row]
                
                cell.configureCategoryCell(category)
                
                return cell
            } else {
                return CategoryCell()
            }
            
        } else {
            cell = searchTableView.dequeueReusableCellWithIdentifier("SearchCell", forIndexPath: indexPath) as! SearchCell
        }
        
        return cell;
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tableView == self.categoryTableView {
            
            let category = self.categories[indexPath.row]
        
            let centerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC") as! MainVC
            centerViewController.category = category
            let centerNav = UINavigationController(rootViewController: centerViewController)
            
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.drawerController!.centerViewController = centerNav
            appDelegate.drawerController!.toggleDrawerSide(.Right, animated: true, completion: nil)
            
        } else {
            
        }
        
    }
    
    func loadCategoriesList() {
        
        
        let PostsQuery: PFQuery =  PFQuery(className:"Category")
        PostsQuery.addDescendingOrder("createdAt")
        PostsQuery.cachePolicy = .NetworkElseCache
        PostsQuery.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                for object in objects! {
                
                   let id = object.objectId as String!
                   let category = Category(categoryId: id, dictionary: object)
                   self.categories.append(category)
                    
                }
                
            }
            
            self.categoryTableView.reloadData()
            
        }
    }

}
