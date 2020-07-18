//
//  TrainingExerciseVC.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 02.06.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import UIKit

class TrainingExerciseVC: ExerciseVC {
//MyCellDelegate {
//
//    var training: TrainingVC!
//
//
//    var trainingExerciseCell = "cellID"
//
//    override func viewDidLoad() {
//        settingsUI()
//
//        exercise.delegate = self
//
//        database = LocalDatabase.shared.connection
//
//        tableView.allowsMultipleSelectionDuringEditing = true
//       // tableView.setEditing(true, animated: true)
//        tableView.register(TrainingExerciseCell.self, forCellReuseIdentifier: trainingExerciseCell)
//
//
//
//    }
//
//
//
////    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
////        if tableView.isEditing {
////            return true
////        }
////        return false
////    }
////
////    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
////        return true
////    }
//
//    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//
//        let favorite = UITableViewRowAction(style: .normal, title: "Просмотр") { (action, index) in
//            let stepsExerciseVC = StepsExerciseVC()
//            stepsExerciseVC.exercise = self.exerciseItems[indexPath.row]
//            stepsExerciseVC.stepsJson.fetchSteps(exercise: self.exerciseItems[indexPath.row].id_exercise!)
//            stepsExerciseVC.stepsJson.fetchContent(exercise: self.exerciseItems[indexPath.row].id_exercise!)
//            self.navigationController?.pushViewController(stepsExerciseVC, animated: true)
//
//        }
//        favorite.backgroundColor = .clear
//
//        return [favorite]
//    }
//
////    override func setEditing(_ editing: Bool, animated: Bool) {
////        super.setEditing(editing, animated: animated)
////        // Toggles the actual editing actions appearing on a table view
////        tableView.setEditing(editing, animated: true)
////    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: trainingExerciseCell, for: indexPath) as! TrainingExerciseCell
//        cell.delegate = self
//        cell.exercise = exerciseItems[indexPath.row]
//
//        return cell
//    }
//
//
//    func didTapButtonInCell(_ cell: TrainingExerciseCell) {
//        print("eerfv")
//
//        if cell.checkTrainingBtn.isSelected {
//            cell.checkTrainingBtn.setImage(#imageLiteral(resourceName: "unCheck"), for: .normal)
//            cell.checkTrainingBtn.isSelected = false
//        } else {
//            cell.checkTrainingBtn.setImage(#imageLiteral(resourceName: "check"), for: .normal)
//            cell.checkTrainingBtn.isSelected = true
//        }
//    }
//
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////
////        let alertController = UIAlertController(title: "Подходы и повторения", message: "Введите кол-во", preferredStyle: .alert)
////        let alertOkAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
////        let alertCancelAction = UIAlertAction(title: "Пропустить", style: .default, handler: nil)
////        alertController.addAction(alertOkAction)
////        alertController.addAction(alertCancelAction)
////
////        alertController.addTextField { (approach) in
////            approach.placeholder = "Повторения"
////        }
////        alertController.addTextField { (repetition) in
////            repetition.placeholder = "Подходы"
////        }
////
////        present(alertController, animated: false, completion: nil)
////
//        let cell = tableView.cellForRow(at: indexPath) as! TrainingExerciseCell
//
//        if cell.checkTrainingBtn.isSelected {
//            cell.checkTrainingBtn.setImage(#imageLiteral(resourceName: "unCheck"), for: .normal)
//            cell.checkTrainingBtn.isSelected = false
//        } else {
//            cell.checkTrainingBtn.setImage(#imageLiteral(resourceName: "check"), for: .normal)
//            cell.checkTrainingBtn.isSelected = true
//        }
//
//
//    }
//
//
    
    
}
