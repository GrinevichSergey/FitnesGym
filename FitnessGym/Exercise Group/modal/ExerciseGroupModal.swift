//
//  ExerciseGroupModal.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 13.05.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import Foundation


struct ExerciseGroupModal: Hashable {
    
    let idGroup: Int?
    let nameGroup: String?
    let imageURL: String?

}

typealias ExerciseGroupsModal = [ExerciseGroupModal]

