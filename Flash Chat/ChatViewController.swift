//
//  ViewController.swift
//  Flash Chat
//
//  Created by Angela Yu on 29/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import Firebase


class ChatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    // Declare instance variables here
    var messageArray : [Message] = [Message]()
    
    // We've pre-linked the IBOutlets
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    @IBOutlet weak var customView: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTableView.separatorStyle = .none
        //pan gesture for keyboard
        let panGesture : UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(keyboardDragged(sender:)))
        customView.addGestureRecognizer(panGesture)
        
        
        //TODO: Set yourself as the delegate and datasource here:
        
        
        
        //TODO: Set yourself as the delegate of the text field here:

        
        
        //TODO: Set the tapGesture here:
        let tap = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tap)

        //TODO: Register your MessageCell.xib file here:
messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        configureTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        retrieveMessages()
        
    }

    ///////////////////////////////////////////
    
    //MARK: - TableView DataSource Methods
    
    //when keyboard dragged
    @objc func keyboardDragged(sender : UIPanGestureRecognizer)
    {
        let velocity = sender.velocity(in: customView)
        if sender.state == UIGestureRecognizer.State.began {
            if(velocity.y>0)
            {
               
                UIView.animate(withDuration: 0.5) {
                    self.messageTextfield.endEditing(true)
                    self.heightConstraint.constant = 50
                    self.view.layoutIfNeeded()
                }
            }
       
            
        }
    }
    
    //TODO: Declare cellForRowAtIndexPath here:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        cell.messageBackgroundWidth.constant = 50
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.senderUsername.text = messageArray[indexPath.row].sender
        
        print(cell.messageBody.intrinsicContentSize.width)
        if(cell.senderUsername.textWidth() >= cell.messageBody.textWidth())
        {
            cell.messageBackgroundWidth.constant = cell.senderUsername.intrinsicContentSize.width + 30
        }
        else{
            cell.messageBackgroundWidth.constant = 70 * self.view.frame.size.width / 100
        }
        
        //for usercell
        
        cell.messageBody1.text = messageArray[indexPath.row].messageBody
        cell.senderUsername1.text = messageArray[indexPath.row].sender
       // cell.avatarImageView1.image = UIImage(named: "egg")
        print(messageArray[indexPath.row].messageBody)
        print(cell.messageBody.intrinsicContentSize.width)
        if(cell.senderUsername1.textWidth() >= cell.messageBody1.textWidth())
        {
            cell.messageBackgroundWidth1.constant = cell.senderUsername1.intrinsicContentSize.width + 30
        }
        else{
            cell.messageBackgroundWidth1.constant = 70 * self.view.frame.size.width / 100
        }
        
        if(cell.senderUsername.text == Auth.auth().currentUser?.email)
        {
            //cell.avatarImageView.image = UIImage(named: "user1image")
            cell.sameUserView.alpha = 1
        }
        else{
            //cell.avatarImageView1.image = UIImage(named: "user2image")
            cell.sameUserView.alpha = 0
        }
        return cell
        
    }
    
    
    //TODO: Declare numberOfRowsInSection here:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    //TODO: Declare tableViewTapped here:
    @objc func tableViewTapped()
    {
        messageTableView.endEditing(true)
    }
    
    
    //TODO: Declare configureTableView here:
    func configureTableView()
    {
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = 120
    }
    
    
    ///////////////////////////////////////////
    
    //MARK:- TextField Delegate Methods
    
    

    
    //TODO: Declare textFieldDidBeginEditing here:
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        UIView.animate(withDuration: 0.5) {
//            self.heightConstraint.constant = 320
//            self.view.layoutIfNeeded()
//        }
    }
    
    
    
    //TODO: Declare textFieldDidEndEditing here:
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        UIView.animate(withDuration: 0.5) {
//            self.heightConstraint.constant = 50
//            self.view.layoutIfNeeded()
//        }
//    }

    
    ///////////////////////////////////////////
    
    
    //MARK: - Send & Recieve from Firebase
    
    
    
    
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        if(messageTextfield.text != "")
        {
        //messageTextfield.endEditing(false)
        //TODO: Send the message to Firebase and save it in our database
        //messageTextfield.isEnabled = false
       // sendButton.isEnabled = false
        let messagesDB = Database.database().reference().child("Messages")
        let messgeDictionary = ["Sender":Auth.auth().currentUser?.email,"MessageBody":messageTextfield.text]
        messagesDB.childByAutoId().setValue(messgeDictionary)
        {
         (error,reference) in
            if(error != nil)
            {
                print("error")
            }
            else
            {
                //self.messageTextfield.isEnabled = true
                //self.sendButton.isEnabled = true
                print("Message saved sucessfully")
                self.messageTextfield.text = ""
            }
        }
        }
    }
    
    //TODO: Create the retrieveMessages method here:
    func retrieveMessages()
    {
        let messageDB = Database.database().reference().child("Messages")
        messageDB.observe(.childAdded) { (snapchat) in
            let snapChatValue = snapchat.value as! Dictionary<String,String>
            let text = snapChatValue["MessageBody"]
            let sender = snapChatValue["Sender"]
            let message = Message()
            message.messageBody = text!
            message.sender = sender!
            self.messageArray.append(message)
            self.configureTableView()
            self.messageTableView.reloadData()
            let indexPath = NSIndexPath(item: self.messageArray.count - 1, section: 0)
            self.messageTableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: false)
        }
    }
    

    
    
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        
        //TODO: Log out the user and send them back to WelcomeViewController
        do {
            try Auth.auth().signOut()
        } catch  {
            print("Error signing in")
        }
        guard navigationController?.popToRootViewController(animated: true) != nil
            else {
            print("No viewControllers to pop off")
                return
        }
        
    }
    
//to find out keyboard height
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            print(keyboardHeight)
            UIView.animate(withDuration: 0.5) {
                if(self.view.frame.size.height >= 812)
                {
                    self.heightConstraint.constant = keyboardHeight + 20
                }
                else{
                    self.heightConstraint.constant = keyboardHeight + 49
                }
                self.view.layoutIfNeeded()
                let indexPath = NSIndexPath(item: self.messageArray.count - 1, section: 0)
                self.messageTableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: false)
            }
        }
    }


}
extension UILabel {
    func textWidth() -> CGFloat {
        return UILabel.textWidth(label: self)
    }
    
    class func textWidth(label: UILabel) -> CGFloat {
        return textWidth(label: label, text: label.text!)
    }
    
    class func textWidth(label: UILabel, text: String) -> CGFloat {
        return textWidth(font: label.font, text: text)
    }
    
    class func textWidth(font: UIFont, text: String) -> CGFloat {
        let myText = text as NSString
        
        let rect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(labelSize.width)
    }
}

