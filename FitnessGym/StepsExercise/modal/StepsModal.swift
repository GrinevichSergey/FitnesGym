//
//  StepsExerciseModal.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 17.05.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import Foundation


struct StepModal {
    var id_steps: Int
    var steps: String
    var exercise_id : Int
}

typealias StepsModal = [StepModal]


struct ContentModal {
    var id_media: Int
    var path: String
    var type : String
    var exercise_id : Int
}
typealias ContentsModal = [ContentModal]
