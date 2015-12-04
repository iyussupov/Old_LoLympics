//
//  DetailsVC.swift
//  LoLympics
//
//  Created by Dev1 on 12/3/15.
//  Copyright © 2015 FXoffice. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {
    
    var post: Post!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(post.title)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func DetailsBackBtn(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
