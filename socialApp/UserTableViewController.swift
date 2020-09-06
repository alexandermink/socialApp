//
//  UserTableViewController.swift
//  socialApp
//
//  Created by Александр Минк on 19.05.2020.
//  Copyright © 2020 Alexander Mink. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift
import Kingfisher


class User {
    var id: Int = 0
    var name: String = ""
    var lastname: String = ""
    var avatar: String = ""
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["first_name"].stringValue
        self.lastname = json["last_name"].stringValue
        self.avatar = json["photo_100"].stringValue
    }
    
    init() { }
    

}




class UserRealm: Object{
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var lastname: String = ""
    @objc dynamic var avatar: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class UserTableViewController: UITableViewController {
    
    

//    let users: [UserList] = [UserList(name: "Alex", lastName: "Blooman", avatar: UIImage(named: "1")!),
//        UserList(name: "Max", lastName: "Freeman", avatar: UIImage(named: "2")!),
//        UserList(name: "John", lastName: "Travolta", avatar: UIImage(named: "3")!),
//        UserList(name: "Pit", lastName: "Digger", avatar: UIImage(named: "4")!)]
    
    let realm = try! Realm()
    
    lazy var usersRealm = realm.objects(UserRealm.self)
    
    var tokenRealm: NotificationToken?
    
    var users: [User] = []
    
    var filteredUsers: [User] = []
    
    var searchState: Bool = false
    
    var selectedRow: Int = 0
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    var gesture = UITapGestureRecognizer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFriends(5)
        
        self.tokenRealm = usersRealm.observe({ (result) in
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
    
    func search(text: String) {
        filteredUsers.removeAll()
        if text.count == 0 {
            self.searchState = false
            self.tableView.reloadData()
        } else {
            self.searchState = true
            self.tableView.reloadData()
        }
        
        for item in users {
            if item.name.lowercased().contains(text.lowercased()) || item.lastname.lowercased().contains(text.lowercased()) {
                filteredUsers.append(item)
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest: UserCollectionViewController = segue.destination as! UserCollectionViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            
            dest.selectedRow = indexPath.row
        }
    }

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchState {
            if filteredUsers.count == 0 {
                return 0
            } else {
                return filteredUsers.count
            }
        } else {
            return usersRealm.count
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "SomeCell", for: indexPath) as! TableViewCell
        
        if searchState {
            if filteredUsers.count == 0 {
                cell.avatarControl.avatar.image = UIImage()
                cell.nameLabel.text = ""
                cell.lastNameLabel.text = ""
            } else {
                
                let image = ImageResource(downloadURL: URL(string: filteredUsers[indexPath.row].avatar)!)
                
                cell.avatarControl.avatar.kf.setImage(with: image)
                cell.nameLabel.text = filteredUsers[indexPath.row].name
                cell.lastNameLabel.text = filteredUsers[indexPath.row].lastname
            }
        } else {
            
            let image = ImageResource(downloadURL: URL(string: usersRealm[indexPath.row].avatar)!)
            
            cell.avatarControl.avatar.kf.setImage(with: image)
            cell.avatarControl.addGestureRecognizer(gesture)
            
            cell.nameLabel.text = usersRealm[indexPath.row].name
            cell.lastNameLabel.text = usersRealm[indexPath.row].lastname
        }
        
        
        return cell
    }
    
    
    func updateUsers(_ users: [User]) {
        //Class UserJSON
        self.users = users
        
        //Class UserRealm
        for user in self.users {
            let userRealm = UserRealm()
            userRealm.id = user.id
            userRealm.name = user.name
            userRealm.lastname = user.lastname
            userRealm.avatar = user.avatar

            try! realm.write {
                realm.add(userRealm, update: .all)
            }
        }

        readUserRealm()
        
        self.tableView.reloadData()
    }
    
    func readUserRealm() {
        let users = realm.objects(UserRealm.self)
        self.users = []
        
        for user in users {
            let tUser = User()
            tUser.id = user.id
            tUser.name = user.name
            tUser.lastname = user.lastname
            tUser.avatar = user.avatar
            self.users.append(tUser)
        }
    }
    
    func getFriends(_ count: Int){
        AF.request("https://api.vk.com/method/friends.get?order=hints&count=\(count)&fields=photo_100&access_token=\(Session.instance.token)&v=5.110").responseJSON { (response) in
            
            
            
            let json = JSON(response.value!)
            
            print(json)
            let users = json["response"]["items"].compactMap{User(json: $0.1)}
            self.updateUsers(users)
            
            
            print(users.count)
        }
    }
    
 

}


extension UserTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.search(text: searchText)
    }
}



//func getFriends(_ count: Int) {
//    AF.request("https://api.vk.com/method/friends.get?order=hints&count=\(count)&access_token=\(Session.instance.token)&v=5.110").responseJSON { (response) in
//        print(response)
//    }
//}





