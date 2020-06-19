//
//  AllGroupsTableViewController.swift
//  socialApp
//
//  Created by Александр Минк on 12.06.2020.
//  Copyright © 2020 Alexander Mink. All rights reserved.
//

import UIKit

class AllGroupsTableViewController: UITableViewController {
    
    var groups: [Group] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! AllGroupsTableViewCell
        
        cell.groupName.text = groups[indexPath.row].name
        cell.groupImage.image = groups[indexPath.row].image
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    @IBAction func addGroup(segue: UIStoryboardSegue){
        if segue.identifier == "addGroup" {
            guard let newGroupController = segue.source as? NewGroupsTableViewController else {return}
            
            if let indexPath = newGroupController.tableView.indexPathForSelectedRow {
                let group = newGroupController.groups[indexPath.row]
                
                if !groups.contains(group) {
                    groups.append(group)
                    tableView.reloadData()
                }
                
            }
        }
    }
    
    

}


struct Group: Equatable {
    var name: String
    var image: UIImage
}
