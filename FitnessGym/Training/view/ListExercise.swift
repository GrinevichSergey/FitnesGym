//
//  ListExercise.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 04.06.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import UIKit

protocol didTapButtonCellView {
    func didTapButtonInCellView(_ controller: StepsExerciseVC)
}

class ListExercise: UIView, UITableViewDataSource, UITableViewDelegate, TrainingGroupDelegate {
   
    var imageURL: String?
    var tableView: UITableView!
    var cellRow = "cellRow"
    var cellSection = "cellSection"
    var trainigGroupItems = TrainingGroups()
    var selectedItems = TrainingGroups()
    var trainingJson = TrainingGroupJson()
    
    var delegate : didTapButtonCellView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
  
        let items = ["Gym", "Home"]
        let segmentControl = UISegmentedControl(items: items)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(tapSegmentControl), for: .valueChanged)
        self.addSubview(segmentControl)

        segmentControl.topAnchor.constraint(equalTo: self.topAnchor, constant:0).isActive = true
        segmentControl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 70).isActive = true
        segmentControl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -70).isActive = true
        segmentControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        segmentControl.layer.cornerRadius = segmentControl.bounds.height / 2
        segmentControl.clipsToBounds = true
     
        tableView = UITableView()
        
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant:10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        
        tableView.register(AddTrainingRowCell.self, forCellReuseIdentifier: cellRow)
        tableView.register(AddTrainingSectionCell.self, forCellReuseIdentifier: cellSection)
        
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        
     
        trainingJson.delegate = self
        trainingJson.fetchExerciseGroupData()
        
        tableView.allowsMultipleSelection = true
 
    }
    
    
    func itemsDowloaded(trainingGroups: TrainingGroup) {
        trainigGroupItems.append(trainingGroups)
  
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 34
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return trainigGroupItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if trainigGroupItems[section].opened == true {
            return trainigGroupItems[section].exercises.count + 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataIndex = indexPath.row - 1
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellSection, for: indexPath) as! AddTrainingSectionCell
            
            cell.nameLabel.text = trainigGroupItems[indexPath.section].nameGroup
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellRow, for: indexPath) as! AddTrainingRowCell
            cell.nameLabel.text = trainigGroupItems[indexPath.section].exercises[dataIndex].name_exercise
            if trainigGroupItems[indexPath.section].isSelected {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                cell.checkImage.image = #imageLiteral(resourceName: "check")
            } else {
                tableView.deselectRow(at: indexPath, animated: false)
                cell.checkImage.image = #imageLiteral(resourceName: "unCheck")
            }
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
  
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        if indexPath.row == 0 {
            if trainigGroupItems[indexPath.section].opened == true {
                trainigGroupItems[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            } else {
                trainigGroupItems[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        }
        
        print("eceercver")
        
        if trainigGroupItems[indexPath.section].isSelected {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            //cell.checkImage.image = #imageLiteral(resourceName: "check")
            trainigGroupItems[indexPath.section].isSelected = true
        } else {
            tableView.deselectRow(at: indexPath, animated: false)
           // cell.checkImage.image = #imageLiteral(resourceName: "unCheck")
            trainigGroupItems[indexPath.section].isSelected = false
        }
        
      
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if indexPath.row != 0 {
            let favorite = UITableViewRowAction(style: .normal, title: "Просмотр") { (action, index) in
                let stepsExerciseVC = StepsExerciseVC()
//                stepsExerciseVC.exercise = self.trainigGroupItems[indexPath.section].exercises[indexPath.row]
//                stepsExerciseVC.stepsJson.fetchSteps(exercise: self.trainigGroupItems[indexPath.section].exercises[indexPath.row].id_exercise!)
//                stepsExerciseVC.stepsJson.fetchContent(exercise:self.trainigGroupItems[indexPath.section].exercises[indexPath.row].id_exercise!)
//                // self.navigationController?.pushViewController(stepsExerciseVC, animated: true)
                self.delegate?.didTapButtonInCellView(stepsExerciseVC)
            }
            favorite.backgroundColor = .clear
            return [favorite]
        }
        
        return []
    }


//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.height, height: 50))
//        let label = UILabel(frame: CGRect(x: 20, y: 5, width: header.frame.width - 10, height: header.frame.height - 10))
//        label.text = NSLocalizedString("Exercise Group", comment: "")
//        label.font = UIFont(name: "Roboto-Regular", size: 22)
//
//        header.addSubview(label)
//        return header
//
//    }
    
    @objc func handleExpendClose() {
       // tableView.deleteRows(at: <#T##[IndexPath]#>, with: <#T##UITableView.RowAnimation#>)
    }
    
    @objc func tapSegmentControl() {
        
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}








