//
//  AvatarView.swift
//  socialApp
//
//  Created by Александр Минк on 22.05.2020.
//  Copyright © 2020 Alexander Mink. All rights reserved.
//

import UIKit

@IBDesignable class AvatarView: UIView {

    var avatar = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAvatar()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAvatar()
    }
    
    func setupAvatar() {
        avatar = UIImageView(frame: self.bounds)
        avatar.layer.cornerRadius = self.frame.width / 2
        avatar.backgroundColor = .green
        self.addSubview(avatar)
    }
    
    @IBInspectable var backColor: UIColor = .red {
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 1 {
        didSet{
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        //self.layer.backgroundColor = backColor.cgColor
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = .zero
    }

}
