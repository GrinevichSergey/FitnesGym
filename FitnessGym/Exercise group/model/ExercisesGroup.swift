//
//  ExercisesGroup.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 04/11/2019.
//  Copyright © 2019 Grinevich Sergey. All rights reserved.
//

import UIKit

class ExercisesGroup: NSObject {
    
    var id: String?
    var name: String?
    var image: [String: String]?
    var gymOrhome: Bool?
    var logoImage: String?
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        id = dictionary["uid"] as? String
        name = dictionary["name"] as? String
        image = dictionary["images"] as? [String: String]
        logoImage = dictionary["logoImage"] as? String
        gymOrhome = dictionary["gumOrhome"] as? Bool
    }
    
}

