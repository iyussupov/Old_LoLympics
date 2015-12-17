//
//  ViewController.swift
//  LoLympics
//
//  Created by Dev1 on 11/30/15.
//  Copyright © 2015 FXoffice. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import ParseFacebookUtilsV4

class LogInVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        self.evo_drawerController?.openDrawerGestureModeMask = .Custom
    }
    
    @IBOutlet weak var usernameTxtFld: UITextField!
    
    @IBOutlet weak var passwordTxtFld: UITextField!
    
    @IBAction func EmailLoginBtnAction(sender: AnyObject) {
        
        if let username = usernameTxtFld.text where username != "", let password = passwordTxtFld.text where password != "" {
            
                PFUser.logInWithUsernameInBackground (username, password:password) {
                    (user: PFUser?, error: NSError?) -> Void in
                if user != nil {
                    self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                } else {
                    ShowAlert.sa.showErrorAlert("Could not loggin", msg: "\(error!.localizedDescription)", viewController: self)
                }
            }
        } else {
            ShowAlert.sa.showErrorAlert("Could not loggin", msg: "Please fill all fields", viewController: self)
        }
        
    }
    
    @IBAction func facebookLoginBtnAction(sender: AnyObject) {
        let permissions = []
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions as? [String]) {
            (user: PFUser?, error: NSError?) -> Void in
            if let user = user {
                if user.isNew {
                    // Create request for user's Facebook data
                    let request = FBSDKGraphRequest(graphPath:"me", parameters:["fields":"id,email,link,first_name"])
                    
                    // Send request to Facebook
                    request.startWithCompletionHandler {
                        
                        (connection, result, error) in
                        
                        if error != nil {
                            // Some error checking here
                            print("Facebook request issue")
                        }
                        else if let userData = result as? [String:AnyObject] {
                            
                            // Access user data
                            user["username"] = userData["first_name"] as? String
                            user["alt_email"] = userData["email"] as? String
                            
                            let userId = userData["id"] as! String
                            let userAvatar = "http://graph.facebook.com/\(userId)/picture?type=square"
                          
                            user["avatar"] = userAvatar
                            
                            user["provider"] = "facebook"
                            user.saveInBackground()
                        }
                    }
                    
                }
                
                self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                
            } else {
                print("Uh oh. The user cancelled the Facebook login.")
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

