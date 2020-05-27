//
//  ExerciseModal.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 15.05.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import Foundation

struct ExerciseModal {
    
    let id_exercise : Int?
    let name_exercise: String?
    let image_url: String?
    let type: Int?
    let description: String?
    let exerciseGroup_id: Int?
    
}

typealias ExercisesModal = [ExerciseModal]

