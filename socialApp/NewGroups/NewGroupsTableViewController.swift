//
//  NewGroupsTableViewController.swift
//  socialApp
//
//  Created by Александр Минк on 12.06.2020.
//  Copyright © 2020 Alexander Mink. All rights reserved.
//

import UIKit

class NewGroupsTableViewController: UITableViewController {

    var groups: [Group] = [
        Group(name: "BMW", image: UIImage(named: "bmw")!),
        Group(name: "Audi", image: UIImage(named: "audi")!),
        Group(name: "Toyota", image: UIImage(named: "toyota")!),
        Group(name: "Mercedes", image: UIImage(named: "mercedes")!),
        Group(name: "Nissan", image: UIImage(named: "nissan")!)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newGroupCell", for: indexPath) as! NewGroupsTableViewCell
        
        cell.newGroupName.text = groups[indexPath.row].name
        cell.newGroupImage.image = groups[indexPath.row].image
        
        return cell
    }
    

}
