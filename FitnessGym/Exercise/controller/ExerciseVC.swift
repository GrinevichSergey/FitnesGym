//
//  ExerciseTableVC.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 15.05.2020.zz
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import UIKit
import AlamofireImage
import SQLite

class ExerciseVC: UIViewController, UITableViewDataSource, UITableViewDelegate, ExerciseJsonDelegate {
  
    lazy var exercise = ExerciseJson()
    var exerciseItems = ExercisesModal()
    fileprivate var cellID = "cellID"
    weak var headerView: HeaderCell?
    var imageURL: String?
    var tableView = UITableView()
    var id_group = Int()
    var typesGroup = Int()
    
    var database: Connection!
    let favoriteTable = Table("Favorite")
    let id_favorite = Expression<Int>("id_favorite")
    let id_exercise = Expression<Int>("id_exercise")
    
    var favoriteItems = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsUI()
        exercise.delegate = self
        
        database = LocalDatabase.shared.connection
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("ТУТ ПРИНИМАЕМ ДАННЫЕ А НЕ ЧЕРЕЗ ДРEГОЙ КОНТРОЛЛЕР")
        exerciseItems.removeAll()
        tableView.reloadData()
        exercise.fetchExerciseData(id_group: id_group, types: typesGroup)
   
    }
    
    func itemsDowloaded(exercises: ExerciseModal, type: Int) {
        if exercises.type == type || exercises.type == TypeExercise.homeAndGym.rawValue {
            exerciseItems.append(exercises)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ExerciseCell
        if listFavorite(id: exerciseItems[indexPath.row].id_exercise) {
            cell.contentView.backgroundColor = .orange
        } else {
            cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        cell.exercise = exerciseItems[indexPath.row]
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderCell.reuseIdentifier) as? HeaderCell
        
        if let imageUrl = imageURL, let url = URL(string: imageUrl)  {
            headerView!.imageExercise.af.cancelImageRequest()
            headerView!.imageExercise.af.setImage(withURL: url, cacheKey: imageUrl)
        }
        
        return headerView
    }
    
    //    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        let contentOffSetY = scrollView.contentOffset.y
    //
    //        if contentOffSetY > 0 {
    //            headerView?.animator.fractionComplete = 0
    //
    //            return
    //        }
    //        headerView?.animator.fractionComplete = abs(contentOffSetY) / 100
    //
    //    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stepsExerciseVC = StepsExerciseVC()
        
        stepsExerciseVC.exercise = exerciseItems[indexPath.row]
        stepsExerciseVC.stepsJson.fetchSteps(exercise: exerciseItems[indexPath.row].id_exercise!)
        stepsExerciseVC.stepsJson.fetchContent(exercise: exerciseItems[indexPath.row].id_exercise!)
        navigationController?.pushViewController(stepsExerciseVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        var rowAction = [UITableViewRowAction]()
        let cell = tableView.cellForRow(at: indexPath)
        
        if !listFavorite(id: exerciseItems[indexPath.row].id_exercise) {
            let favorite = UITableViewRowAction(style: .normal, title: "Favorite") { (action, index) in
                if let id = self.exerciseItems[indexPath.row].id_exercise {
                    self.insertFavorite(id: id)
                }
                cell?.contentView.backgroundColor = .orange
            }
            favorite.backgroundColor = .orange
            rowAction.append(favorite)
            
        } else {
            let delete = UITableViewRowAction(style: .normal, title: "Delete") { (action, index) in
                if let id = self.exerciseItems[indexPath.row].id_exercise {
                    self.deleteFavoriteItems(id: id)
                }
                cell?.contentView.backgroundColor = .white
            }
            delete.backgroundColor = .red
            rowAction.append(delete)
            
        }
        return rowAction
    }
    
    
    fileprivate func insertFavorite(id: Int) {
        let insertFavorite = self.favoriteTable.insert(self.id_exercise <- id)
        do {
            try self.database.run(insertFavorite)
            // tableView.reloadData()
        } catch {
            print(error)
        }
    }
    
    func deleteFavoriteItems(id: Int) {
        let favorite = self.favoriteTable.filter(self.id_exercise == id)
        let delete = favorite.delete()
        do {
            try self.database.run(delete)
            //  tableView.reloadData()
        } catch {
            print(error)
        }
    }
    
    fileprivate func listFavorite(id: Int?) -> Bool {
        var isFavorite = Bool()
        do {
            let favorites = try self.database.prepare(self.favoriteTable)
            for favorite in favorites {
                if id == favorite[self.id_exercise] {
                    isFavorite = true
                    break
                } else {
                    isFavorite = false
                }
            }
        } catch {
            print(error)
        }
        return isFavorite
    }
    
    
}


//MARK: form settings
extension ExerciseVC {
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
//
     func settingsUI() {
        view.backgroundColor =  #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
        navigationItem.title = "Exercise"
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 16)!], for: .normal)
//        navigationItem.rightBarButtonItem = self.editButtonItem
        setupTableView()
    }
    
    
    fileprivate func setupTableView() {
        
        view.addSubview(tableView)
        tableView.backgroundColor =  #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ExerciseCell.self, forCellReuseIdentifier: cellID)
        tableView.register(HeaderCell.self, forHeaderFooterViewReuseIdentifier: HeaderCell.reuseIdentifier)
        tableView.tableFooterView = UIView(frame: .zero)
        
    }
    
    
}

