//
//  CustomMessageCell.swift
//  Flash Chat
//
//  Created by Angela Yu on 30/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class CustomMessageCell: UITableViewCell {


    @IBOutlet weak var messageBackgroundWidth1: NSLayoutConstraint!
    @IBOutlet weak var sameUserView: UIView!
    @IBOutlet weak var messageBackgroundWidth: NSLayoutConstraint!
    @IBOutlet var messageBackground: UIView!
    @IBOutlet var messageBackground1: UIView!
    @IBOutlet var avatarImageView: UIImageView!
     @IBOutlet var avatarImageView1: UIImageView!
    @IBOutlet var messageBody: UILabel!
    @IBOutlet var messageBody1: UILabel!
    @IBOutlet var senderUsername1: UILabel!
    @IBOutlet var senderUsername: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code goes here
        
        
        
    }


}
