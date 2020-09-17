//
//  RequestURL.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 13.05.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import Foundation

enum RequestURL: String {
    
    case ExerciseGroup = "http://95.217.12.115/ExerciseGroup.php"
    case Exercise = "http://95.217.12.115/Exercise.php?exerciseGroup_id="
    case ExerciseCount = "http://95.217.12.115/exerciseCount.php?exerciseGroup_id=1&type=1&type1=2"
    case Steps = "http://95.217.12.115/steps.php?exercise_id="
    case Content = "http://95.217.12.115/media.php?exercise_id="
    case Favorite = "http://95.217.12.115/favorite.php?exercise_id="
    case FaviriteExercise =  "http://95.217.12.115/favoriteExercise.php?exerciseGroup_id="
    
}

enum RequestTestURL {
    case ExerciseCount(request: String, id_group: Int, type: Int, type1: Int)
}
