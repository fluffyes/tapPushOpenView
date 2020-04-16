//
//  ConversationViewController.swift
//  Telegrammy2
//
//  Created by Soulchild on 15/04/2020.
//  Copyright © 2020 fluffy. All rights reserved.
//

import UIKit

struct Message {
    let senderName : String
    let message : String
}

class ConversationViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageBubbleView: UIView!
    
    
    var messages: [Message] = []
    var senderDisplayName = "Toriel"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        messageBubbleView.clipsToBounds = true
        messageBubbleView.layer.cornerRadius = 15.0
        
        
        title = senderDisplayName
        
        avatarImageView.image = UIImage(named: senderDisplayName)
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 20.0
        
        switch senderDisplayName {
        case "Asriel":
            messageLabel.text = "Howdy, it's me!"
        case "Sans":
            messageLabel.text = "It's a beautiful day outside"
        default:
            messageLabel.text = "Don't worry, my child"
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
