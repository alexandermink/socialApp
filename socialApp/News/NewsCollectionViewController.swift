//
//  NewsCollectionViewController.swift
//  socialApp
//
//  Created by Александр Минк on 26.08.2020.
//  Copyright © 2020 Alexander Mink. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift
import Kingfisher

private let reuseIdentifier = "NewsCell"

class News {
    var post_id: Int = 0
    var source_id: Int = 0
    var text: String = ""
    var likes: Int = 0
    var comments: Int = 0
    var reposts: Int = 0
    var views: Int = 0
    var date: Int = 0
    
    init(json: JSON) {
        self.post_id = json["post_id"].intValue
        let id = json["source_id"].stringValue.components(separatedBy: "-")
        print("id - " + "\(id)")
        self.source_id = Int(id[1])!
        self.text = json["text"].stringValue
        self.likes = json["likes"]["count"].intValue
        self.comments = json["comments"]["count"].intValue
        self.reposts = json["reposts"]["count"].intValue
        self.views = json["views"]["count"].intValue
        self.date = json["date"].intValue
    }
    
    init() { }
    
}

class NewsGroups {
    var id: Int = 0
    var photo_100: String = ""
    var name: String = ""
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.id = json["id"].intValue
        self.photo_100 = json["photo_100"].stringValue
    }
    
    init () { }
}

class NewsRealm: Object {
    @objc dynamic var post_id: Int = 0
    @objc dynamic var source_id: Int = 0
    @objc dynamic var text: String = ""
    @objc dynamic var likes: Int = 0
    @objc dynamic var comments: Int = 0
    @objc dynamic var reposts: Int = 0
    @objc dynamic var views: Int = 0
    @objc dynamic var date: Int = 0
    
    override class func primaryKey() -> String? {
        return "post_id"
    }
}

class NewsGroupsRealm: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var photo_100: String = ""
    @objc dynamic var name: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class NewsCollectionViewController: UICollectionViewController {
    
    let realm = try! Realm()
    
    lazy var newsRealm = realm.objects(NewsRealm.self)
    lazy var newsGroupsRealm = realm.objects(NewsGroupsRealm.self)
    
    
    var newsTokenRealm: NotificationToken?
    
    var news: [News] = []
    var newsGroups: [NewsGroups] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        getNews(5)
        
        self.newsTokenRealm = newsRealm.observe({ (result) in
            switch result {
            case .error(let error):
                print(error.localizedDescription)
            case .initial(_):
                print("Инициализация")
            case .update(_, deletions: _, insertions: _, modifications: _):
                print("Update News")
                self.collectionView.reloadData()
            }
        })
    }

    

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return newsRealm.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewsCollectionViewCell
    
        
        // Configure the cell
        for group in newsGroupsRealm {
            if group.id == newsRealm[indexPath.row].source_id {
                let authorAvatarImage = ImageResource(downloadURL: URL(string: group.photo_100)!)
                cell.authorAvatarImage.kf.setImage(with: authorAvatarImage)
                cell.authorNameLabel.text = group.name
            }
        }
        
        
        let likeImage = UIImage(systemName: "heart")
        cell.likeImage.image = likeImage
        cell.likeLabel.text = "\(newsRealm[indexPath.row].likes)"
        
        let commentImage = UIImage(systemName: "bubble.left")
        cell.commentImage.image = commentImage
        cell.commentLabel.text = "\(newsRealm[indexPath.row].comments)"
        
        let repostImage = UIImage(systemName: "arrowshape.turn.up.right")
        cell.repostImage.image = repostImage
        cell.repostLabel.text = "\(newsRealm[indexPath.row].reposts)"
        
        let viewsImage = UIImage(systemName: "eye.fill")
        cell.viewsImage.image = viewsImage
        cell.viewsLabel.text = "\(newsRealm[indexPath.row].views)"
        
        cell.contentTextView.text = newsRealm[indexPath.row].text
        
        print("_____POST_______________")
        print("\(newsRealm[indexPath.row].comments)")
        print("\(newsRealm[indexPath.row].likes)")
        print("\(newsRealm[indexPath.row].reposts)")
        print("\(newsRealm[indexPath.row].views)")
        print(newsRealm[indexPath.row].text)
        print("_____POST_______________")

        
    
        return cell
    }
    
    func updateNews(_ news: [News]) {
        
        //class News
        self.news = news
        
        //class NewsRealm
        for item in self.news {
            let newsRealm = NewsRealm()
            newsRealm.post_id = item.post_id
            newsRealm.source_id = item.source_id
            newsRealm.text = item.text
            newsRealm.likes = item.likes
            newsRealm.comments = item.comments
            newsRealm.reposts = item.reposts
            newsRealm.views = item.views
            newsRealm.date = item.date
            
            try! realm.write {
                realm.add(newsRealm, update: .all)
            }
        }
        
        readNewsRealm()
        
        self.collectionView.reloadData()
        
    }
    
    func updateNewsGroups(_ newsGroups: [NewsGroups]) {
        
        //class News
        self.newsGroups = newsGroups
        
        //class NewsRealm
        for item in self.newsGroups {
            let newsGroupsRealm = NewsGroupsRealm()
            newsGroupsRealm.id = item.id
            newsGroupsRealm.name = item.name
            newsGroupsRealm.photo_100 = item.photo_100
            
            try! realm.write {
                realm.add(newsGroupsRealm, update: .all)
            }
        }
        
        readNewsGroupsRealm()
        
        self.collectionView.reloadData()
        
    }
    
    func readNewsRealm() {
        
        let news = realm.objects(NewsRealm.self)
        self.news = []
        
        for item in news {
            let tNews = News()
            tNews.post_id = item.post_id
            tNews.source_id = item.source_id
            tNews.text = item.text
            tNews.likes = item.likes
            tNews.comments = item.comments
            tNews.reposts = item.reposts
            tNews.views = item.views
            tNews.date = item.date
            self.news.append(tNews)
        }
        
        
    }
    
    func readNewsGroupsRealm() {
        
        let newsGroups = realm.objects(NewsGroupsRealm.self)
        self.newsGroups = []
        
        for item in newsGroups {
            let tNewsGroups = NewsGroups()
            tNewsGroups.id = item.id
            tNewsGroups.name = item.name
            tNewsGroups.photo_100 = item.photo_100
            self.newsGroups.append(tNewsGroups)
            
            
        }
        
        
    }

    
    func getNews(_ count: Int) {
        
        AF.request("https://api.vk.com/method/newsfeed.get?filters=post&count=\(count)&source_ids=groups&access_token=\(Session.instance.token)&v=5.122").responseJSON { (response) in
            print("________NEWS______________")
            print (response)
            print("________NEWS______________")
            
            let json = JSON(response.value!)
            
            let news = json["response"]["items"].compactMap{News(json: $0.1)}
            let newsGroups = json["response"]["groups"].compactMap{NewsGroups(json: $0.1)}
            self.updateNews(news)
            self.updateNewsGroups(newsGroups)
            
        }
    }
    

}
