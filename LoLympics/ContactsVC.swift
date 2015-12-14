//
//  ContactsVC.swift
//  LoLympics
//
//  Created by Ingwar on 12/13/15.
//  Copyright © 2015 FXoffice. All rights reserved.
//

import UIKit
import MessageUI

class ContactsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBAction func openMenu(sender: AnyObject) {
        self.evo_drawerController?.toggleDrawerSide(.Left, animated: true, completion: nil)
    }
    
    @IBAction func openSearch(sender: AnyObject) {
        self.evo_drawerController?.toggleDrawerSide(.Right, animated: true, completion: nil)
    }
    
    var contactsMenuItems:[String] = ["www.facebook.com/lolympicsapp","@lolympicsapp","www.lololympics.com","support@lololympics.com"];
    var contactsMenuIcons:[String] = ["","","",""];
    
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
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.headerImage.clipsToBounds = true
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contactsMenuItems.count;
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactsCell", forIndexPath: indexPath) as! ContactsCell
        
        cell.contactsMenuLbl.text = contactsMenuItems[indexPath.row]
        cell.menuItemIcon.text = contactsMenuIcons[indexPath.row]
        
        if indexPath.row == contactsMenuItems.count - 1 {
            cell.menuSeparatorView.hidden = true
        }
        
        return cell;
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch(indexPath.row)  {
            
        case 0:
            let facebookUrl = NSURL(string: "fb://profile/F05uxkCGgn0")
            if (UIApplication.sharedApplication().canOpenURL(facebookUrl!)) {
                UIApplication.sharedApplication().openURL(facebookUrl!)
            } else {
                UIApplication.sharedApplication().openURL(NSURL(string:"www.facebook.com/lolympicsapp")!)
            }
            
            break;
            
        case 1:
            let twitterUrl = NSURL(string: "twitter:///user?screen_name=lolympicsapp")
            if (UIApplication.sharedApplication().canOpenURL(twitterUrl!)) {
                UIApplication.sharedApplication().openURL(twitterUrl!)
            } else {
                UIApplication.sharedApplication().openURL(NSURL(string:"https://twitter.com/lolympicsapp")!)
            }
            
            break;
            
        case 2:
            
            UIApplication.sharedApplication().openURL(NSURL(string:"http://www.lololympics.com")!)
            
            break;
            
        case 3:
            
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(configureMailViewController(), animated: true, completion: nil)
            } else {
                ShowAlert.sa.showErrorAlert("Could Not Send Email", msg: "Your device could not send email. Please check email configuration and try again.", viewController: self)
            }
            
            break;
            
        default:
            
            print("\(contactsMenuItems[indexPath.row]) is selected");
            
        }
        
    }
    
    func configureMailViewController() -> MFMailComposeViewController{
    
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["support@lololympics.com"])
        mailComposerVC.setSubject("LoLympics Support")
        mailComposerVC.setMessageBody("Hi!", isHTML: false)
        
        return mailComposerVC
    
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    

}
