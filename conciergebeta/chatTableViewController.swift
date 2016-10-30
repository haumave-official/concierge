//
//  chatTableViewController.swift
//  conciergebeta
//
//  Created by Max Suvorov on 29.10.16.
//  Copyright © 2016 Max Suvorov. All rights reserved.
//

import UIKit

class chatTableViewController: UITableViewController {
    
    var reuseCellIdentifier = "chatCell"
    
    private var isEmpty = true
    
    var sourceArray: [Message] = [] {
        didSet {
            if ( sourceArray.count > 0 ) {
                self.isEmpty = false
            }
            else {
                self.isEmpty = true
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 30
        
        tableView.separatorStyle = .none
        
        self.tableView.register(UINib(nibName: "chatCell", bundle: nil), forCellReuseIdentifier: reuseCellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /* Public methods: */
    
    func scrollToTheLastMessage() {
        if ( !isEmpty ) {
            let messageIndexPath = IndexPath(row: self.sourceArray.count-1, section: 0)
            
            self.tableView.scrollToRow(at: messageIndexPath, at: .bottom, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                //self.tableView.scrollToRow(at: messageIndexPath, at: .bottom, animated: true)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sourceArray.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    private func getMessageItem (indexPath: IndexPath) -> Message? {
        if ( self.sourceArray.count >= indexPath.row + 1 ) {
            let item: Message = self.sourceArray[indexPath.row]
            
            return item
        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: chatCellTableViewCell! = tableView.dequeueReusableCell(withIdentifier: reuseCellIdentifier) as? chatCellTableViewCell
        
        if ( cell == nil ) {
            cell = chatCellTableViewCell(style: .subtitle, reuseIdentifier: reuseCellIdentifier)
        }
        
        cell.selectionStyle = .none
    
        if let messageItem = self.getMessageItem(indexPath: indexPath) {
            cell.messageTextLabel.text = messageItem.text
        }
        
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
