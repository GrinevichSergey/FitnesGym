//
//  TrainingModalExercise.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 06.06.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import Foundation

class TrainingGroup {
    
    let idGroup: Int?
    let nameGroup: String?
    let imageURL: String?
    var opened: Bool
    var isSelected: Bool
    let exercises: [ExerciseModal]
    
    init(idGroup: Int, nameGroup: String, imageURL: String, opened: Bool, isSelected: Bool, exercise: ExercisesModal) {
        self.idGroup = idGroup
        self.nameGroup = nameGroup
        self.imageURL = imageURL
        self.exercises = exercise
        self.opened = opened
        self.isSelected = isSelected
    }
}

typealias TrainingGroups = [TrainingGroup]


