//
//  ExerciseJson.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 15.05.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol ExerciseJsonDelegate: class {
    func itemsDowloaded(exercises: ExerciseModal, type: Int)
    var  imageURL: String? { get set }
}

class ExerciseJson {
    
    weak var delegate : ExerciseJsonDelegate?
    
    func fetchExerciseData(id_group: Int, types: Int) {
        
        DispatchQueue.main.async {
            
            AF.request(RequestURL.Exercise.rawValue + String(id_group)).responseJSON { (response) in
                
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
                        self.delegate?.itemsDowloaded(exercises: exercise, type: types)
                        // self.delegate?.imageURL = exercise.image_url
                        
                    }
                    
                case .failure(let error): print(error.localizedDescription)
                    
                }
                
                
            }
            
        }
        
        
    }
    
    
    func fetchExerciseFavoriteData(id_group: Int, types: Int, exercise_id: Int) {
        
        DispatchQueue.main.async {
            
            AF.request(RequestURL.FaviriteExercise.rawValue + String(id_group) + "&exercise_id=" + String(exercise_id)).responseJSON { (response) in
                
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
                        self.delegate?.itemsDowloaded(exercises: exercise, type: types)
                        //       self.delegate?.imageURL = exerciseGroup.imageURL
                        
                    }
                    
                case .failure(let error): print(error.localizedDescription)
                    
                }
                
                
            }
            
        }
        
        
    }

    
}
