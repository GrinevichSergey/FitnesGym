//
//  TrainingModal.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 01.06.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import Foundation

class TrainingModal: NSObject {
    
    var idTraining: Int
    var nameTraining: String
    var descriptionTraining: String
   
    
    init(id: Int, name: String, description: String) {
        self.idTraining = id
        self.nameTraining = name
        self.descriptionTraining = description

    }

}

typealias TrainingsModal = [TrainingModal]

