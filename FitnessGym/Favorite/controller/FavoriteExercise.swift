//
//  FavoriteExercise.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 28.05.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import Foundation
import UIKit


class FavoriteExerciseGroup: ExerciseVC {

    override func viewWillAppear(_ animated: Bool) {
        
        exerciseItems.removeAll()
        tableView.reloadData()
        
        do {
            let favorites = try self.database.prepare(self.favoriteTable)
            for favorite in favorites {
                exercise.fetchExerciseFavoriteData(id_group: id_group, types: typesGroup, exercise_id: favorite[id_exercise])
            }
        } catch {
            print(error)
        }

    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let delete = UITableViewRowAction(style: .normal, title: "Delete") { (action, index) in
            if let id = self.exerciseItems[indexPath.row].id_exercise {
                self.deleteFavoriteItems(id: id)
                self.exerciseItems.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                if self.exerciseItems.count == 0 {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        delete.backgroundColor = .red
      
        return [delete]
    }
    
    
}
