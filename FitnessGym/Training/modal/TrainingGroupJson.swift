//
//  TrainingGroupJson.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 06.06.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol TrainingGroupDelegate: class {
    func itemsDowloaded(trainingGroups: TrainingGroup)
}

class TrainingGroupJson {
    
    weak var delegate : TrainingGroupDelegate?
    var exercise = ExercisesModal()
    var exerciseGroup = ExerciseGroupsModal()
    
    func fetchExerciseGroupData() {
        
        DispatchQueue.main.async {
            AF.request(RequestURL.ExerciseGroup.rawValue).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    for item in json.arrayValue {
                        let id = item["id_group"].intValue
                        let name = item["name_group"].stringValue
                        let imageURL = item["image_url"].stringValue
                        let exerciseCount = item["exerciseCount"].intValue
                        let exerciseGroup = ExerciseGroupModal(idGroup: id, nameGroup: name, imageURL: imageURL, exerciseCount: exerciseCount)
                        self.exerciseGroup.append(exerciseGroup)
                        
                    }
                    self.fetchExerciseData()
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func fetchExerciseData() {
        for group in exerciseGroup {
            
            DispatchQueue.main.async {
                AF.request(RequestURL.Exercise.rawValue + String(group.idGroup!)).responseJSON { (response) in
                    
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        for item in json.arrayValue {
                            
                            let id = item["id_exercise"].intValue
                            let name = item["name_exercise"].stringValue
                            let imageURL = item["image_url"].stringValue
                            let type = item["type"].intValue
                            let description = item["description"].stringValue
                            let exerciseGroup_id = item["exerciseGroup_id"].intValue
                            
                            let exercise = ExerciseModal(id_exercise: id, name_exercise: name, image_url: imageURL, type: type, description: description , exerciseGroup_id: exerciseGroup_id)
                            
                            self.exercise.append(exercise)
                        }
                        
                    case .failure(let error): print(error.localizedDescription)
                        
                    }
                    
                    let trainingGroup = TrainingGroup(idGroup: group.idGroup!, nameGroup: group.nameGroup!, imageURL: group.imageURL!, opened: false, isSelected: false, exercise: self.exercise)
                    self.delegate?.itemsDowloaded(trainingGroups: trainingGroup)
                    self.exercise.removeAll()
                }
                
            }
            
        }
    }
    
    
    
}
