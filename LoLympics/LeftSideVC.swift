//
//  LeftSideVC.swift
//  LoLympics
//
//  Created by Dev1 on 12/11/15.
//  Copyright © 2015 FXoffice. All rights reserved.
//

import UIKit

class LeftSideVC: UIViewController {

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //
        self.navigationController?.view.setNeedsLayout()
        //
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "contentSizeDidChangeNotification:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        //
    }

}
