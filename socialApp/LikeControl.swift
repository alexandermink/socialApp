//
//  LikeControl.swift
//  socialApp
//
//  Created by Александр Минк on 26.05.2020.
//  Copyright © 2020 Alexander Mink. All rights reserved.
//

import UIKit

class LikeControl: UIControl {
    
    var flag = true

    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 21, height: 21))
    let image = UIImage(systemName: "heart")
    var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        uisutup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        uisutup()
    }
    
    func uisutup() {
        
        label.text = "0"
        imageView = UIImageView(frame: CGRect(x: self.bounds.width - 21, y: 0, width: 21, height: 21))
        imageView.image = image
        imageView.tintColor = .blue
        imageView.contentMode = .scaleAspectFit
        
        self.addSubview(label)
        self.addSubview(imageView)
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        //print("begin")
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        
        
        if flag {
            label.text = "1"
            imageView.tintColor = .red
            flag = false
        } else {
            label.text = "0"
            imageView.tintColor = .blue
            flag = true
        }
    }
}
