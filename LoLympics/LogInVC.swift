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

class LogInVC: UIViewController, UITextFieldDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        self.evo_drawerController?.openDrawerGestureModeMask = .Custom
    }
    
    @IBOutlet weak var usernameTxtFld: UITextField!
    
    @IBOutlet weak var passwordTxtFld: UITextField!
    
    @IBOutlet weak var emailLoginHover: BtnViewStyle!
    
    @IBAction func emailLoginDown(sender: AnyObject) {
        self.emailLoginHover.backgroundColor = UIColor(red: 239/255, green: 154/255, blue: 92/255, alpha: 1)
    }
    @IBAction func EmailLoginBtnAction(sender: AnyObject) {
        self.emailLoginHover.backgroundColor = UIColor(red: 244/255, green: 121/255, blue: 31/255, alpha: 1)
        
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
    
    @IBOutlet weak var facebookLoginHover: BtnViewStyle!
    @IBAction func facebookLoginDown(sender: AnyObject) {
       self.facebookLoginHover.backgroundColor = UIColor(red: 84/255, green: 117/255, blue: 187/255, alpha: 1)
    }
    @IBAction func facebookLoginBtnAction(sender: AnyObject) {
        self.facebookLoginHover.backgroundColor = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1)
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
                print("The user cancelled the Facebook login.")
            }
        }
        
    }
    
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    
    /*
    @IBAction func googleLoginDown(sender: AnyObject) {
        self.signInButton.backgroundColor = UIColor(red: 238/255, green: 98/255, blue: 86/255, alpha: 1)
    }
    @IBAction func googleLoginBtnAction(sender: AnyObject) {
        self.signInButton.backgroundColor = UIColor(red: 220/255, green: 70/255, blue: 57/255, alpha: 1)
    }
    */
    
    // Stop the UIActivityIndicatorView animation that was started when the user
    // pressed the Sign In button
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        //myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func signIn(signIn: GIDSignIn!,
        presentViewController viewController: UIViewController!) {
            self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!,
        dismissViewController viewController: UIViewController!) {
            self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
    }

}

