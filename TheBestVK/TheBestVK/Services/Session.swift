//
//  Session.swift
//  TheBestVK
//
//  Created by Станислав Лемешаев on 14.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

class Session {
    private init() {}
    
    public static let shared = Session()
    
    var token = ""
    var userId = 0
    
}
