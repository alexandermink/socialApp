//
//  UserCollectionViewController.swift
//  socialApp
//
//  Created by Александр Минк on 22.05.2020.
//  Copyright © 2020 Alexander Mink. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "Cell"

class UserCollectionViewController: UICollectionViewController {

    var users: [User] = []
    
    var selectedRow: Int = 0
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        

        // Do any additional setup after loading the view.
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! ProfileImageCollectionViewCell
        
        
        //cell.ProfileImage.image = users[selectedRow].avatar
        
        return cell
    }
    
    

    

}
