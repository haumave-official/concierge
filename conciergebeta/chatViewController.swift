//
//  ViewController.swift
//  conciergebeta
//
//  Created by Max Suvorov on 27.10.16.
//  Copyright © 2016 Max Suvorov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var chatBottomBar_bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var messageTextView: UITextView!
    
    var chatTableVC = chatTableViewController()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupKeyBoard()
        
        self.setupChatTableView()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    private func setupKeyBoard () {
        NotificationCenter.default.addObserver(self, selector: #selector( keyboardShown(notification:) ), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    private func setupChatTableView () {
        self.chatTableVC.tableView.frame = self.chatView.bounds
        
        self.chatView.addSubview(self.chatTableVC.tableView)
        
        /* Setup top offset. */
        self.chatTableVC.tableView.contentInset = UIEdgeInsetsMake(80, 0, 0, 0)
        
        let message1 = Message(text: "Rollce")
        let message2 = Message(text: "Rollce Royce")
        let message3 = Message(text: "Ferrari")
        let message4 = Message(text: "Mercedes-Benz w222 s63 AMG")
        let message5 = Message(text: "Range Rover Autobiography 2016")
        
        self.chatTableVC.sourceArray = [
            message1,
            message2,
            message3,
            message4,
            message5
        ]
        
        DispatchQueue.main.async {
            self.chatTableVC.tableView.reloadData()
            self.chatTableVC.scrollToTheLastMessage()
        }
    }
    
    func keyboardShown (notification: Notification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame: CGRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            self.chatBottomBar_bottomConstraint.constant = keyboardFrame.size.height
            
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.view.layoutIfNeeded()
                
                let tableViewBottonInset = keyboardFrame.size.height+70+30 /* 70 is bottom bar height, 30 is margin to look better. */
                
                self.chatTableVC.tableView.contentInset = UIEdgeInsetsMake(80, 0, tableViewBottonInset, 0)
            })
            
        }
    }
    
    private func messageIsValid (messageText: String) -> Bool {
        if ( messageText.characters.count == 0 ) {
            return false
        }
        
        return true
    }
    
    
    @IBAction func sendMessage () {
        if let newMessageText = self.messageTextView.text {
        
            if ( self.messageIsValid(messageText: newMessageText) ) {
                
                let newMessageInstance = Message(text: newMessageText)
                
                self.chatTableVC.sourceArray.append(newMessageInstance)
                
                 self.chatTableVC.tableView.reloadData()
                
                DispatchQueue.main.async {
                   
                    self.chatTableVC.scrollToTheLastMessage()
                }
            }
            
        }
    }
    
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
    }
    
    /* Gesture recognition. */
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if(navigationController!.viewControllers.count > 1){
            return true
        }
        return false
    }
}


