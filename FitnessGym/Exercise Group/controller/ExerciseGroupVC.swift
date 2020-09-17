//
//  ExerciseGroupTableVCTableViewController.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 26.04.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//


import UIKit
import SwiftyJSON

enum TypeExercise: Int {
    case homeAndGym  = 1 
    case gym         = 2
    case home        = 3
}

class ExercisesGroupVC: UITableViewController, ExerciseGroupDelegate {
    
    var exerciseCount: Int?
    let cellId = "cellId"
    lazy var exerciseGroup = ExerciseGroupJson()
    lazy var exerciseGroupItems = ExerciseGroupsModal()
    fileprivate let padding :  CGFloat = 10
    
    var typeExercise = TypeExercise.gym.rawValue
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInputComponents()
        exerciseGroup.fetchExerciseGroupData()
        exerciseGroup.fetchExerciseCount(groupID: 1, type: 1, type1: 2)
        exerciseGroup.delegate = self

    }


    func itemsDowloaded(exerciseGroups: ExerciseGroupModal) {
        
        self.exerciseGroupItems.append(exerciseGroups)
        exerciseGroupItems.removeDuplicates()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseGroupItems.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ExerciseGroupCell
        
        cell.exerciseGroup = exerciseGroupItems[indexPath.row]
        cell.countExercise.text = "\(String(exerciseCount!)) exercise"
        if (indexPath.row % 2 == 0) {
            cell.contentTextViewLeftConstraint?.isActive = true
        } else {
            cell.contentTextViewRightConstraint?.isActive = true
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let exercise = ExerciseVC()
        exercise.id_group = exerciseGroupItems[indexPath.row].idGroup!
        exercise.typesGroup = typeExercise
        exercise.imageURL = exerciseGroupItems[indexPath.row].imageURL
        self.navigationController?.pushViewController(exercise, animated: true)

    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        //segmentController
        let items = ["Gym", "Home"]
        let segmentControl = UISegmentedControl(items: items)
        segmentControl.frame = CGRect(x: 40, y: 10, width: header.frame.width - 80, height: header.frame.height - 10)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(tapSegmentControl), for: .valueChanged)

        segmentControl.layer.cornerRadius = segmentControl.bounds.height / 2
        segmentControl.clipsToBounds = true
        
        
        header.addSubview(segmentControl)
        
        return header
     
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //отступ ячеек
        let verticalPadding: CGFloat = 10
        
        let maskLayer = CALayer()
        
         //тень ячейки

        maskLayer.cornerRadius = 10
        //       self.layer.borderWidth = 1.0
        //       self.layer.borderColor = UIColor.black.cgColor
        maskLayer.backgroundColor = UIColor.white.cgColor
        maskLayer.shadowColor = UIColor.lightGray.cgColor
        maskLayer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        maskLayer.shadowRadius = 1.0
        maskLayer.shadowOpacity = 1.0
        maskLayer.masksToBounds = false
    
        maskLayer.frame = CGRect(x: cell.bounds.origin.x + 10, y: cell.bounds.origin.y, width: cell.bounds.width - 20, height: cell.bounds.height).insetBy(dx: padding, dy: verticalPadding / 2)
        cell.layer.mask = maskLayer
  
    }
    
 
    @objc func tapSegmentControl(segment: UISegmentedControl) -> Void {
        switch segment.selectedSegmentIndex {
        case 0:
            print("gym")
            print(exerciseGroupItems.count)
            typeExercise = TypeExercise.gym.rawValue
        case 1:
            print("home")
            print(exerciseGroupItems.count)
            typeExercise = TypeExercise.home.rawValue
        default:
            break
        }
        
    }
    
}


extension ExercisesGroupVC {
    
    func setupInputComponents()  {
        
        navigationItem.title = "Fitness Gym"
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 15)!], for: .normal)
         
        //обновление для таблицы
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Обновление")
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl!)
        
        //tableView
        tableView.register(ExerciseGroupCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView(frame: .zero)
    
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "background"))
    }
    
    @objc func refresh() {
        
        tableView.reloadData()
        refreshControl!.endRefreshing()
        
    }
    
}


extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
