//
//  ExercisesGroupTableVC.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 02/11/2019.
//  Copyright © 2019 Grinevich Sergey. All rights reserved.
//

import UIKit
import Firebase

class ExercisesGroupTableVC: UITableViewController {
    
    let cellId = "cellId"
    var exercisesGroup = [ExercisesGroup]()
    var timer: Timer?

    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setupInputComponents()
        refresh()
          
    }
    
    
    private func attempReloadofTable() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector:  #selector(self.handlerReloadTable), userInfo: nil, repeats: false)
    }
    
    @objc func handlerReloadTable(){
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    //MARK: Получение данных из базы и запись в массив
    func observeExercisesGroup() {
     
        let ref = Database.database().reference().child("ExercisesGroup")
        ref.observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                    
                let myExercisesGroup = ExercisesGroup(dictionary: dictionary as [String: AnyObject])
                self.exercisesGroup.append(myExercisesGroup)

            }
            //обновление
            self.attempReloadofTable()
            
        }, withCancel: nil)
    }


    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercisesGroup.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ExercisesGroupViewCell
    
        
        let exercises = exercisesGroup[indexPath.row]
        cell.textLabel?.text = exercises.name
        cell.textLabel?.font = UIFont(name:"Roboto-Regular", size:22)
        
        if let image = exercises.image {
            if let logo = image["logoImage"]
            {
                cell.exercisesGroupImageView.loadImageCacheWidthUrlString(urlString: logo)
            }
        }
        
        if tableView.isEditing == true {
            
            cell.exercisesImageLeftConstraint?.constant = 50
            
        } else {

            cell.exercisesImageLeftConstraint?.constant = 8
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
          return true
      }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let ref = Database.database().reference().child("ExercisesGroup")
            let delete: ExercisesGroup = exercisesGroup[indexPath.row]
            let uk = delete.id
            ref.child(uk!).removeValue()
            exercisesGroup.remove(at: indexPath.item)
            tableView.reloadData()
            
        }
        
        
    }
    
    
    
    @objc func didTapAddButton(){

        let addExercisesGroup = AddExercisesGroupVC()
        navigationController?.pushViewController(addExercisesGroup, animated: true)
    }
    
    
    @objc func didTapEditButton() {
        

        if tableView.isEditing == true {
            
            tableView.isEditing = false
            tableView.reloadData()
       
        } else {
            
            tableView.isEditing = true
            tableView.reloadData()
           
        }
        
    }
    
    @objc func tapSegmentControl(segment: UISegmentedControl) -> Void {
        switch segment.selectedSegmentIndex {
        case 0:
             print("segmentControll0")
        case 1:
             print("segmentControll1")
        default:
            break
        }
       
    }
    
}


extension ExercisesGroupTableVC{
    
    func setupInputComponents()  {
        
        //segmentController
        let items = ["Зал", "Дом"]
        let segmentControl = UISegmentedControl(items: items)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(tapSegmentControl), for: .valueChanged)
        tableView.tableHeaderView = segmentControl
        
        //обновление для таблицы
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Обновление")
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl!)
        
        //tableView
        tableView.register(ExercisesGroupViewCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    @objc func refresh() {
        
        exercisesGroup.removeAll()
        tableView.reloadData()
        observeExercisesGroup()
        refreshControl!.endRefreshing()

    }
    
    
    
}

