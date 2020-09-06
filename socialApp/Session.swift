//
//  Session.swift
//  socialApp
//
//  Created by Александр Минк on 19.06.2020.
//  Copyright © 2020 Alexander Mink. All rights reserved.
//

import Foundation

class Session {
    
    static let instance = Session()
    
    private init() {}
    
    var token: String = ""
    var userId: Int = 0
    
    
    
    
}
