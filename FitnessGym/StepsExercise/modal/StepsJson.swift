//
//  StepsExerciseJson.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 17.05.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire


protocol StepsJsonDelegate: class {
    func itemsStepsDowloaded(steps: StepModal)
    func itemsContentDowloaded(content: ContentModal)
}


class StepsJson {
    
    weak var delegate: StepsJsonDelegate?
    
    func fetchSteps(exercise id : Int)  {
        
        AF.request(RequestURL.Steps.rawValue + String(id)).responseJSON { (response) in
            
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                for item in json.arrayValue {
                    let id = item["id_steps"].intValue
                    let step = item["steps"].stringValue
                    let exercise_id = item["exercise_id"].intValue
                    
                    let steps = StepModal(id_steps: id, steps: step, exercise_id: exercise_id)
                    self.delegate?.itemsStepsDowloaded(steps: steps)
                    
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            
        }
        
        
    }
    
    func fetchContent(exercise id : Int)  {
        
        AF.request(RequestURL.Content.rawValue + String(id)).responseJSON { (response) in
            
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                for item in json.arrayValue {
                    let id = item["id_media"].intValue
                    let path = item["path"].stringValue
                    let type = item["type_media"].stringValue
                    let exercise_id = item["exercise_id"].intValue
                    
                    let content = ContentModal(id_media: id, path: path, type: type, exercise_id: exercise_id)
                    self.delegate?.itemsContentDowloaded(content: content)
         
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            
        }
        
        
    }
    
    
    
    
}

