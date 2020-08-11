//
//  UserCollectionViewController.swift
//  socialApp
//
//  Created by Александр Минк on 22.05.2020.
//  Copyright © 2020 Alexander Mink. All rights reserved.
//

import UIKit
import Kingfisher


class UserCollectionViewController: UICollectionViewController {

    var users: [User] = []
    
    var selectedRow: Int = 0
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! ProfileImageCollectionViewCell
        
        let image = ImageResource(downloadURL: URL(string: users[selectedRow].avatar)!)
        cell.ProfileImage.kf.setImage(with: image)
        
        return cell
    }
    
    

    

}
