//
//  FriendSearchViewController.swift
//  dummyEmoji
//
//  Created by Elliot Richard John Winch on 1/23/18.
//  Copyright © 2018 Elliot Winch. All rights reserved.
//

import UIKit
import Firebase

//To be: a more important class
class User : NSObject {
    
    var UID : String
    var username : String = ""
    var favColor: UIColor
    var friends : [User]
    
    init(UID: String, username: String, favColor: UIColor){
        self.UID = UID
        self.username = username
        self.favColor = favColor
        self.friends = [User]()
    }
    
    init(UID: String, username: String, favColor: UIColor, friends: [User]){
        self.UID = UID
        self.username = username
        self.favColor = favColor
        self.friends = friends
    }
}

class UserTableCell : UITableViewCell {
    
    @IBOutlet weak var favColorImage: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    public var user : User?
    
}

class FriendSearchViewController: UITableViewController {
    
    let usersRef = Database.database().reference().child("users")
    
    var loadedUsers : [User] = []
    
    var maxLoadedUsers = 10

    override func viewDidLoad() {
        super.viewDidLoad()

        loadUserInfoFromDatabase()
        
    }
    
    func loadUserInfoFromDatabase(){
        
        usersRef.observe(.value) { (snapshot) in
            
            for userUID in snapshot.children{
                
                if let userData = userUID as? DataSnapshot{
                    
                    let username = userData.childSnapshot(forPath: "email").value as! String
                    
                    let favColorData = userData.childSnapshot(forPath: "favColor")
                    let favColorR = CGFloat(favColorData.childSnapshot(forPath: "r").value as! Int)
                    let favColorG = CGFloat(favColorData.childSnapshot(forPath: "g").value as! Int)
                    let favColorB = CGFloat(favColorData.childSnapshot(forPath: "b").value as! Int)

                    let favColor = UIColor(red: favColorR / CGFloat(256),
                                           green: favColorG / CGFloat(256),
                                           blue: favColorB / CGFloat(256),
                                           alpha: CGFloat(1))
                    
                    self.loadedUsers.append(User(UID: userData.key, username: username, favColor: favColor))
                    
                }
            }
            
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadedUsers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> 
        UITableViewCell {
            
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableCell", for: indexPath) as? UserTableCell else {
            fatalError("Dequeued cell not of type: UserTableCell")
        }
    
        let user = loadedUsers[indexPath.row]
    
        cell.favColorImage.backgroundColor = user.favColor
        cell.usernameLabel.text = user.username
        
        cell.user = user

        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let userTableCell = self.tableView(tableView, cellForRowAt: indexPath) as? UserTableCell else {
            fatalError("Dequeued cell not of type: UserTableCell")
        }
        
        
        if(userTableCell.user != nil) {
            let alert = UIAlertController(title: "Add Friend?", message: "Would you like to add \(userTableCell.user!.username) as a friend?", preferredStyle: .alert)
            
            
            alert.addAction(UIAlertAction(title: "Yes", style: .`default`, handler: { _ in
                
                let currentUserUID = Auth.auth().currentUser!.uid
                
                Database.database().reference().child("users/\(currentUserUID)/friends").updateChildValues([userTableCell.user!.UID : true])
                
                Database.database().reference().child("users/\(userTableCell.user!.UID)/friends").updateChildValues([currentUserUID : true])
            }))
            
            alert.addAction(UIAlertAction(title: "No", style: .`default`, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
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
