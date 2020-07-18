//
//  HomeVC.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 21.05.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    var exerciseID = "exerciseID"

    fileprivate var padding:  CGFloat = 10
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        
    }
  
    
    
    
    
}


extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width - 2 * padding, height: 100)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = indexPath.section
        
        if section == 0 {
            let cellExercise = collectionView.dequeueReusableCell(withReuseIdentifier: exerciseID, for: indexPath) as! ExerciseHomeCell
            
            return cellExercise
        
            
        } else {
            return UICollectionViewCell()
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let section = indexPath.section
        
        if section == 0 {
            let groupExercise = ExercisesGroupVC()
            navigationController?.pushViewController(groupExercise, animated: true)
            
        } else if section == 1 {
            let favoriteVC = FavoriteGroupVC()
            navigationController?.pushViewController(favoriteVC, animated: true)
            
        } else if section == 2 {
            let trainingVC = TrainingVC()
            navigationController?.pushViewController(trainingVC, animated: true)
            
        }
        
        
    }
    
    
    fileprivate func setupCollectionViewLayout() {
        //layout customization
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
            //отступ между ячейками
            // layout.minimumLineSpacing = 24
        }
    }
    
}


extension HomeVC {
    
    
    func setupUI() {
        
        view.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        navigationItem.title = "Home"
        
        
        collectionView.register(ExerciseHomeCell.self, forCellWithReuseIdentifier: exerciseID)
   
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor,constant: 16).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        
        collectionView.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        collectionView.contentInsetAdjustmentBehavior = .never
        
        
        setupCollectionViewLayout()
    }
    
}

