//
//  ViewController.swift
//  socialApp
//
//  Created by Александр Минк on 28.04.2020.
//  Copyright © 2020 Alexander Mink. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    
    @IBAction func login(_ sender: Any) {
        if(emailTF.text == "login" && passTF.text == "pass"){
            
        }
    }
    
}

