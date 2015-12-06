//
//  CustomDetailVC.swift
//  LoLympics
//
//  Created by Ingwar on 12/6/15.
//  Copyright © 2015 FXoffice. All rights reserved.
//

import UIKit

let offset_HeaderStop:CGFloat = 243.0 // At this offset the Header stops its transformations

class DetailVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var post: Post!
    
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

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        headerImage.clipsToBounds = true
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        return tableView.dequeueReusableCellWithIdentifier("cell")!
        
        
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
