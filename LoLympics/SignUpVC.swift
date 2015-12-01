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

    func signUp() {
        
        let user = PFUser()
        user.username = UsernameTxtFld.text
        user.password = PasswordTxtFld.text
        user.email = EmailTxtFld.text
        
        user["provider"] = "email"
        
        user.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if error == nil {
                // Hooray! Let them use the app now.
                print("Move next")
            } else {
                // Examine the error object and inform the user.
                print(error)
            }
        }
    
    }
    
    @IBAction func SignUpBtnAction(sender: AnyObject) {
        
        signUp()
        
    }
    
    @IBAction func SignUpBackBtn(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
