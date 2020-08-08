//
//  AllGroupsTableViewController.swift
//  socialApp
//
//  Created by Александр Минк on 12.06.2020.
//  Copyright © 2020 Alexander Mink. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Group {
    let id: Int
    var name: String = ""
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
    }
}

class AllGroupsTableViewController: UITableViewController {
    
    var groups: [Group] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getGroups(5)

    }

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! AllGroupsTableViewCell
        
        cell.groupName.text = groups[indexPath.row].name
        //cell.groupImage.image = groups[indexPath.row].image
        
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
//                let group = newGroupController.groups[indexPath.row]
                
//                if !groups.contains(group) {
//                    groups.append(group)
//                    tableView.reloadData()
//                }
                
            }
        }
    }
    
    func updateGroups(_ groups: [Group]) {
        self.groups = groups
        self.tableView.reloadData()
        
    }
    
    func getGroups(_ count: Int) {
        AF.request("https://api.vk.com/method/groups.get?count=\(count)&extended=1&access_token=\(Session.instance.token)&v=5.110").responseJSON { (response) in
            print(response)
            
            let json = JSON(response.value!)
            
            let groups = json["response"]["items"].compactMap{Group(json: $0.1)}
            self.updateGroups(groups)
        }
    }
    
    

}


struct GroupList: Equatable {
    var name: String
    var image: UIImage
}
