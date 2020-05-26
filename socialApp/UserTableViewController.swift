//
//  UserTableViewController.swift
//  socialApp
//
//  Created by Александр Минк on 19.05.2020.
//  Copyright © 2020 Alexander Mink. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    

    let users: [UserList] = [UserList(name: "Alex", avatar: UIImage(named: "1")!),
    UserList(name: "Max", avatar: UIImage(named: "2")!),
    UserList(name: "John", avatar: UIImage(named: "3")!),
    UserList(name: "Pit", avatar: UIImage(named: "4")!)]
    
    var selectedRow: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest: UserCollectionViewController = segue.destination as! UserCollectionViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            dest.users = users
            dest.selectedRow = indexPath.row
        }
    }

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SomeCell", for: indexPath) as! TableViewCell

        cell.avatarControl.avatar.image = users[indexPath.row].avatar
        cell.nameLabel.text = users[indexPath.row].name
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        //let cell = tableView.cellForRow(at: indexPath)
//        //selectedRow = indexPath.row
//
//
//    }
    
   
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ImageDataSegue" else { return }
        guard let destination = segue.destination as? UserCollectionViewController else { return }
        destination.selectedRow = self.selectedRow
    }*/
    
    


}

struct UserList {
    var name: String
    var avatar: UIImage
}
