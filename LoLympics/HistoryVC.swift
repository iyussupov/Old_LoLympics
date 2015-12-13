//
//  HistoryVC.swift
//  LoLympics
//
//  Created by Ingwar on 12/13/15.
//  Copyright © 2015 FXoffice. All rights reserved.
//

import UIKit

class HistoryVC: UIViewController {

    
    @IBOutlet weak var headerImage: UIImageView!
    @IBAction func openMenu(sender: AnyObject) {
        self.evo_drawerController?.toggleDrawerSide(.Left, animated: true, completion: nil)
    }
    
    @IBAction func openSearch(sender: AnyObject) {
        self.evo_drawerController?.toggleDrawerSide(.Right, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.headerImage.clipsToBounds = true
    }

}
