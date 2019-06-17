//
//  RegisterViewController.swift
//  Flash Chat
//
//  This is the View Controller which registers new users with Firebase
//

import UIKit
import Firebase
import SVProgressHUD
import NotificationBannerSwift
class RegisterViewController: UIViewController {

    
    //Pre-linked IBOutlets

    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

  
    @IBAction func registerPressed(_ sender: AnyObject) {
        

        SVProgressHUD.show()
        //TODO: Set up a new user on our Firbase database
        Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (result, error) in
            if(error != nil)
            {
                 print("Error")
                let banner = NotificationBanner(title: "Something went wrong", subtitle: "Try again", style: .danger)
                banner.show()
            }
            else{
                print("Registration Sucessful")
                self.performSegue(withIdentifier: "goToChat", sender: self)
                let banner = NotificationBanner(title: "Registered sucessfully", subtitle: "", style: .success)
                banner.show()
            }
            SVProgressHUD.dismiss()
        }
        

        
        
    } 
    
    
}
