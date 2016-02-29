//
//  LoginSignupViewController.swift
//  Timeline
//
//  Created by admin on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class LoginSignupViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var bioTextField: UITextField!
    
    @IBOutlet weak var urlTextField: UITextField!
    
    @IBOutlet weak var actionButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewBasedOnMode()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    enum ViewMode {
        case Login
        case Signup
        case Edit
    }
    
    var mode: ViewMode = .Signup
    
    var user: User?
    
    func updateViewBasedOnMode() {
        switch mode {
        case .Login:
            usernameTextField.hidden = true
            bioTextField.hidden = true
            urlTextField.hidden = true
            
            actionButton.setTitle("Login", forState: .Normal)
            
        case .Signup:
            actionButton.setTitle("Signup", forState: .Normal)
        case .Edit:
            actionButton.setTitle("Update", forState: .Normal)
            emailTextField.hidden = true
            passwordTextField.hidden = true
            
            if let user = self.user {
                
                usernameTextField.text = user.username
                bioTextField.text = user.bio
                urlTextField.text = user.url
            }
    
        }

        
    }
    
    func updateWithUser(user: User) {
        self.user = user
        mode = .Edit
    }
    
    var fieldsAreValid: Bool {
        get {
            switch mode {
            case .Login:
                return (emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty)
            case .Signup:
                return (usernameTextField.text!.isEmpty || emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty)
            case .Edit:
                return(usernameTextField.text!.isEmpty)
            }
        }
    }
    
    @IBAction func actionButtonTapped(sender: AnyObject) {
        if fieldsAreValid {
            switch mode {
            case .Login :
                return UserController.authenticateUser(emailTextField.text!, password: passwordTextField.text!, completion: { (success, user) -> Void in
                    if success, let _ = user {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        self.presentValidationAlertWithTitle("Unable to Login", message: "Please check username/password")
                    }
                    
                    })
            case .Signup:
                return UserController.createUser(emailTextField.text!, username: usernameTextField.text!, password: passwordTextField.text!, bio: bioTextField.text, url: urlTextField.text, completion: { (success, user) -> Void in
                    if success, let _ = user {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        self.presentValidationAlertWithTitle("Unable to create user", message: "Please check your information and try again")
                    }
                    
                })
            case .Edit:
                return UserController.updateUser(self.user!, username: self.usernameTextField.text!, bio: self.bioTextField.text, url: self.urlTextField.text, completion: { (success, user) -> Void in
                    if success {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        self.presentValidationAlertWithTitle("Unable to Update User", message: "Please check information and try again")
                    }
                })
            }
        } else {
            presentValidationAlertWithTitle("Missing Info", message: "Please check info and try again")
        }

    }
        func presentValidationAlertWithTitle(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    
    
    
    
}
