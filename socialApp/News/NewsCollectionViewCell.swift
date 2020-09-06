//
//  NewsCollectionViewCell.swift
//  socialApp
//
//  Created by Александр Минк on 26.08.2020.
//  Copyright © 2020 Alexander Mink. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var authorAvatarImage: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    
    
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentImage: UIImageView!
    
    @IBOutlet weak var repostLabel: UILabel!
    @IBOutlet weak var repostImage: UIImageView!
    
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var viewsImage: UIImageView!
    
    
}
