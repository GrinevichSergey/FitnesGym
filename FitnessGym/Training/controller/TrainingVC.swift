//
//  TrainingVC.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 22.05.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import UIKit
import SQLite


class TrainingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let trainingCell = "trainingCell"
    var trainingTableView = UITableView()
    var trainingItems = TrainingsModal()
    var trainingTable = Table("Training")
    let id_training = Expression<Int>("id_training")
    let name = Expression<String>("name")
    let discription = Expression<String>("discription")
    var database : Connection!
    static let shared = TrainingVC()
    var id_ = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Training"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector(addTraining))
        self.navigationController?.setToolbarHidden(false, animated: false)
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let deleteButton: UIBarButtonItem = UIBarButtonItem(title: "delete", style: .plain, target: self, action: #selector(didPressDelete))
        self.toolbarItems = [flexible, deleteButton]
        
        navigationItem.leftBarButtonItem = editButtonItem
        setupTrainingTable()
        
        database = LocalDatabase.shared.connection
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        listTraining()
        
        trainingTableView.reloadData()
    }
    
    fileprivate func listTraining() {
        trainingItems.removeAll()
        do {
            let trainings = try database.prepare(self.trainingTable)
            for training in trainings {
                let training = TrainingModal(id: training[id_training], name: training[name], description: training[discription])
                trainingItems.append(training)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: trainingCell, for: indexPath) 
        cell.textLabel?.text = trainingItems[indexPath.row].nameTraining
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  let listTraining = ListTrainingVC()
        id_ = trainingItems[indexPath.row].idTraining
    //    navigationController?.pushViewController(listTraining, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let editViewController = segue.destination as? TrainingExerciseVC {
            print(id_)
            editViewController.id_group = id_
           }
       }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
//    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
//        if tableView.isEditing {
//            return true
//        }
//        return false
//    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        // Toggles the actual editing actions appearing on a table view
        trainingTableView.setEditing(editing, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            trainingItems.remove(at: indexPath.item)
            trainingTableView.reloadData()
        }
    }

    
    @objc func addTraining() {
        
        let addTraining = AddTrainingVC()
        present(UINavigationController(rootViewController: addTraining), animated: true, completion: nil)
        
    }
    
    @objc func didPressDelete() {
    let selectedRows = self.trainingTableView.indexPathsForSelectedRows
    if selectedRows != nil {
        for var selectionIndex in selectedRows! {
            while selectionIndex.item >= trainingItems.count {
                selectionIndex.item -= 1
            }
            tableView(trainingTableView, commit: .delete, forRowAt: selectionIndex)
        }
    }
    }
    
    func setupTrainingTable() {
        
        trainingTableView.dataSource = self
        trainingTableView.delegate = self
        
        view.addSubview(trainingTableView)
        
        trainingTableView.register(UITableViewCell.self, forCellReuseIdentifier: trainingCell)
        
        trainingTableView.translatesAutoresizingMaskIntoConstraints = false
        trainingTableView.backgroundColor =   #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
        trainingTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        trainingTableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        trainingTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trainingTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        trainingTableView.tableFooterView = UIView(frame: .zero)
        
      //  trainingTableView.allowsMultipleSelectionDuringEditing = true
    }
    
}
