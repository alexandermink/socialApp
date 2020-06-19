//
//  ViewController.swift
//  socialApp
//
//  Created by Александр Минк on 28.04.2020.
//  Copyright © 2020 Alexander Mink. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var purpleView: UIView!
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var pinkView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        purpleView.layer.cornerRadius = purpleView.frame.size.width / 2
        purpleView.clipsToBounds = true
        
        blueView.layer.cornerRadius = blueView.frame.size.width / 2
        blueView.clipsToBounds = true
        
        pinkView.layer.cornerRadius = pinkView.frame.size.width / 2
        pinkView.clipsToBounds = true
        
        purpleView.alpha = 0
        blueView.alpha = 0
        pinkView.alpha = 0
        
        animateLoad()
        
    }

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    
    @IBAction func login(_ sender: Any) {
        if(emailTF.text == "login" && passTF.text == "pass"){
            
        }
    }
    
    func animateLoad() {
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [.repeat, .autoreverse], animations: {
            self.purpleView.alpha = 1
        })
        UIView.animate(withDuration: 0.5, delay: 0.6, options: [.repeat, .autoreverse], animations: {
            self.pinkView.alpha = 1
        })
        UIView.animate(withDuration: 0.5, delay: 0.9, options: [.repeat, .autoreverse], animations: {
            self.blueView.alpha = 1
        })
    }
    
}
