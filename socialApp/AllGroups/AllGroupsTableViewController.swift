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
import RealmSwift
import Kingfisher

class Group {
    var id: Int = 0
    var name: String = ""
    var avatar: String = ""
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.avatar = json["photo_100"].stringValue
    }
    
    init() { }
}

class GroupRealm: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var avatar: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class AllGroupsTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    lazy var groupsRealm = realm.objects(GroupRealm.self)
    
    var tokenRealm: NotificationToken?
    
    var groups: [Group] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getGroups(5)
        
        self.tokenRealm = groupsRealm.observe({ (result) in
            switch result {
            case .error(let error):
                print(error.localizedDescription)
            case .initial(_):
                print("Инициализация")
            case .update(_, deletions: _, insertions: _, modifications: _):
                print("Update")
                self.tableView.reloadData()
            }
        })

    }

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groupsRealm.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! AllGroupsTableViewCell
        
        cell.groupName.text = groupsRealm[indexPath.row].name
        
        let image = ImageResource(downloadURL: URL(string: groupsRealm[indexPath.row].avatar)!)
        
        cell.groupImage.kf.setImage(with: image)
        
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
            
//            if let indexPath = newGroupController.tableView.indexPathForSelectedRow {
//                let group = newGroupController.groups[indexPath.row]
//
//                if !groups.contains(group) {
//                    groups.append(group)
//                    tableView.reloadData()
//                }
//
//            }
        }
    }
    
    func updateGroups(_ groups: [Group]) {
        
        //Class Group
        self.groups = groups
        
        //Class GroupRealm
        for group in self.groups {
            let groupRealm = GroupRealm()
            groupRealm.id = group.id
            groupRealm.name = group.name
            groupRealm.avatar = group.avatar

            try! realm.write {
                realm.add(groupRealm, update: .all)
            }
        }
        
        readGroupRealm()
        
        self.tableView.reloadData()
    }
    
    func readGroupRealm() {
        
        let groups = realm.objects(GroupRealm.self)
        self.groups = []
        
        for group in groups {
            let tGroup = Group()
            tGroup.id = group.id
            tGroup.name = group.name
            tGroup.avatar = group.avatar
            self.groups.append(tGroup)
        }
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
