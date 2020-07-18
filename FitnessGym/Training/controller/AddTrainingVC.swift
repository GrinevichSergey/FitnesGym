//
//  AddTrainingVC.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 30.05.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import UIKit
import SQLite

class AddTrainingVC: UIViewController, didTapButtonCellView {
   
    
    var listView = ListExercise()
    
    let nameTraining: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Names"
        textField.textAlignment = .left
        textField.setBottomBorder()
        return textField
    }()
    
    
    let discriptionTraining: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Description..."
        textField.font = UIFont(name: "Roboto-Regular", size: 18)
        textField.textColor = .lightGray
        textField.textAlignment = .left
        return textField
    }()
    
//    let addExerciseBtn : UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor =  #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
//        let removeAdsText = NSLocalizedString("Choose exercises", comment: "")
//        button.setTitle(removeAdsText, for: .normal)
//        button.titleLabel?.textColor = .black
//        button.setTitleColor(.black, for: .normal)
//        button.layer.cornerRadius = 5
//        button.layer.borderColor = UIColor.black.cgColor
//        button.addTarget(self, action: #selector(tapAddExerciseBtn), for: .touchUpInside)
//        button.startAnimatingPressActions()
//        return button
//    }()
    
    let trainigTable = Table("Training")
    let id_training = Expression<Int>("id_training")
    let name = Expression<String>("name")
    let discription = Expression<String>("discription")
    
    var database: Connection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        
        listView.delegate = self
        
        database = LocalDatabase.shared.connection
    }
    
    func didTapButtonInCellView(_ controller: StepsExerciseVC) {
        navigationController?.pushViewController(controller, animated: true)
    }
       
    @objc func saveTrainigToData() {
        insertTraining()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func createTrainingTable() {
        let createTable = self.trainigTable.create { (table) in
            table.column(self.id_training, primaryKey: true)
            table.column(self.name)
            table.column(self.discription)
        }
        do {
            try self.database.run(createTable)
            print("Created table")
        } catch {
            print(error)
        }
    }
    
    
    fileprivate func insertTraining() {
        createTrainingTable()
        let insertTraining = self.trainigTable.insert(self.name <- nameTraining.text!, self.discription <- discriptionTraining.text!)
        do {
            try database.run(insertTraining)
        } catch {
            print(error.localizedDescription)
        }
    }
    
//   @objc fileprivate func tapAddExerciseBtn() {
//    
//        let trainingGroup = TrainingGroupExerciseVC()
//        navigationController?.pushViewController(trainingGroup, animated: true)
//        
//    }
    

}

extension AddTrainingVC {
    
    fileprivate func setupUI() {
        
        view.backgroundColor =  #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
        navigationItem.title = "Add workout"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTrainigToData))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action:#selector(cancelButton))
        
        let containerView:  UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.layer.cornerRadius = 10
            view.layer.shadowColor = UIColor.lightGray.cgColor
            view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            view.layer.shadowRadius = 1.0
            view.layer.shadowOpacity = 1.0
            view.layer.masksToBounds = false
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        view.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 5).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
      
        
        
        let stackView = UIStackView(arrangedSubviews:
            [nameTraining, discriptionTraining]
        )
        stackView.axis = .vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.spacing = 5.0
        containerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        nameTraining.widthAnchor.constraint(equalToConstant: 300).isActive = true
        nameTraining.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        discriptionTraining.widthAnchor.constraint(equalToConstant: 300).isActive = true
        discriptionTraining.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        let viewController: UIView = {
            let viewController = UIView()
            viewController.translatesAutoresizingMaskIntoConstraints = false
            return viewController
            
        }()
        
        view.addSubview(viewController)
        
        viewController.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10).isActive = true
        viewController.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        viewController.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        viewController.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 0).isActive = true
        

        let  listExercise = ListExercise()
        listExercise.translatesAutoresizingMaskIntoConstraints = false
        viewController.addSubview(listExercise)
        
        listExercise.topAnchor.constraint(equalTo: viewController.topAnchor, constant:0).isActive = true
        listExercise.leadingAnchor.constraint(equalTo: viewController.leadingAnchor, constant: 0).isActive = true
        listExercise.trailingAnchor.constraint(equalTo: viewController.trailingAnchor, constant: 0).isActive = true
        listExercise.bottomAnchor.constraint(equalTo: viewController.bottomAnchor, constant: 0).isActive = true
        

//        addExerciseBtn.widthAnchor.constraint(equalToConstant: 300).isActive = true
//        addExerciseBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
}

