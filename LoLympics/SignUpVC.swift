//
//  SignUpVC.swift
//  LoLympics
//
//  Created by Dev1 on 12/1/15.
//  Copyright © 2015 FXoffice. All rights reserved.
//

import UIKit
import Parse

class SignUpVC: UIViewController {

    @IBOutlet weak var UsernameTxtFld: UITextField!
    @IBOutlet weak var EmailTxtFld: UITextField!
    @IBOutlet weak var PasswordTxtFld: UITextField!
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = true
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignUpBtnAction(sender: AnyObject) {
        
        if let username = UsernameTxtFld.text where username != "", let password = PasswordTxtFld.text where password != "", let email = EmailTxtFld.text where email != "" {
            let user = PFUser()
            user.username = UsernameTxtFld.text
            user.password = PasswordTxtFld.text
            user.email = EmailTxtFld.text
            
            user["provider"] = "email"
            
            user.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                if error == nil {
                    self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                } else {
                    ShowAlert.sa.showErrorAlert("Could not create an account", msg: "\(error!.localizedDescription)", viewController: self)
                }
            }
        } else {
            ShowAlert.sa.showErrorAlert("Could not create an account", msg: "Please fill all fields", viewController: self)
        }
        
    }
    
    @IBAction func SignUpBackBtn(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
