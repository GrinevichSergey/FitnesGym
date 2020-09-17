//
//  EGParseJson.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 13.05.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol ExerciseGroupDelegate: class {
    func itemsDowloaded(exerciseGroups: ExerciseGroupModal)
    var exerciseCount: Int? {get set}
}

class ExerciseGroupJson {
    
    weak var delegate : ExerciseGroupDelegate?
    
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
                        self.delegate?.itemsDowloaded(exerciseGroups: exerciseGroup)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func fetchFavoriteData(exercise_id: Int) {
        
        DispatchQueue.main.async {
            AF.request(RequestURL.Favorite.rawValue + String(exercise_id)).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    for item in json.arrayValue {
                        let id = item["id_group"].intValue
                        let name = item["name_group"].stringValue
                        let imageURL = item["image_url"].stringValue
                        let exerciseCount = item["exerciseCount"].intValue
                        let exerciseGroup = ExerciseGroupModal(idGroup: id, nameGroup: name, imageURL: imageURL, exerciseCount: exerciseCount)
                        self.delegate?.itemsDowloaded(exerciseGroups: exerciseGroup)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func fetchExerciseCount(groupID: Int, type: Int, type1: Int) {
        
        DispatchQueue.main.async {
            AF.request(RequestURL.ExerciseCount.rawValue).responseJSON { (response) in
                
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    for item in json.arrayValue {
                        
                        let exerciseCount = item["ExerciseCount"].intValue
                        self.delegate?.exerciseCount = exerciseCount

                    }
                    
                case .failure(let error): print(error.localizedDescription)
                    
                }
                
                
            }
        }
  
        
    }

}

//MARK: //Codable parse
//struct ExerciseGroup: Codable {
//
//    let idGroup, nameGroup, imageURL: String
//
//    enum CodingKeys: String, CodingKey {
//        case idGroup = "id_group"
//        case nameGroup = "name_group"
//        case imageURL = "image_url"
//    }
//}
//
//
//class Networking: NSObject {
//
//    func getItem(url: String)  {
//
//        let url = URL(string: url)
//        if let url = url {
//            let session = URLSession(configuration: .default)
//
//            session.dataTask(with: url) { (data, response, error) in
//                if error == nil {
//                    self.parseJson(data: data!)
//                }
//            }.resume()
//        }
//    }
//
//    func parseJson(data: Data)  {
//
//    }
//}
//
//func fetchExerciseGroupData(data: Data) {
//    let decoder = JSONDecoder()
//    if let exercise = try? decoder.decode(ExerciseGroups.self, from: data) {
//        delegate?.itemsDosloaded(exerciseGroups: exercise)
//    }
//
//}
