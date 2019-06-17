//
//  LogInViewController.swift
//  Flash Chat
//
//  This is the view controller where users login


import UIKit
import Firebase
import SVProgressHUD
import NotificationBannerSwift
class LogInViewController: UIViewController {

    //Textfields pre-linked with IBOutlets
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
    @IBAction func logInPressed(_ sender: AnyObject) {
        
        SVProgressHUD.show()
        //TODO: Log in the user
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (authDataResult, error) in
            if error != nil{
                print("Error logging in")
                let banner = NotificationBanner(title: "Username/Password doesn't match", subtitle: "Try again", style: .danger)
                banner.show()

            }
            else{
                print("Login Sucessfull")
                self.performSegue(withIdentifier: "goToChat", sender: self)
                let banner = NotificationBanner(title: "Login Successful", subtitle: "", style: .success)
                banner.show()
            }
            SVProgressHUD.dismiss()
        }
        
    }
    


    
}  
