//
//  ExerciseTableVC.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 15.05.2020.zz
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import UIKit
import AlamofireImage



class ExerciseVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, ExerciseJsonDelegate {
    
    lazy var exercise = ExerciseJson()
    fileprivate var exerciseItems = ExercisesModal()
    fileprivate var cellID = "cellID"
    fileprivate var headerID = "headerID"
    fileprivate let padding :  CGFloat = 10
    weak var headerView: HeaderCell?
    var exerciseCell: ExerciseCell?
    var imageURL: String?
   // var starImage = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsUI()
        exercise.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("ТУТ ПРИНИМАЕМ ДАННЫЕ А НЕ ЧЕРЕЗ ДРEГОЙ КОНТРОЛЛЕР")

    }
    
    init() {
        super.init(collectionViewLayout: StretchyHeaderLayout())
     
    }
 
    deinit {
        headerView?.animator.stopAnimation(true)
        print("Exercise deinit")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func itemsDowloaded(exercises: ExerciseModal, type: Int) {
        
        if exercises.type == type || exercises.type == TypeExercise.homeAndGym.rawValue {
            exerciseItems.append(exercises)
            
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return exerciseItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ExerciseCell
        
        //cell.backgroundColor = .black
        cell.exercise = exerciseItems[indexPath.row]
        
//        if starImage {
//            cell.starImage.isHidden = true
//        } else {
//            cell.starImage.isHidden = false
//        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //  return .init(width: view.frame.width, height: 70)
        return .init(width: view.frame.width - 2 * padding, height: 70)
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as? HeaderCell
        
        if let imageUrl = imageURL, let url = URL(string: imageUrl)  {
            headerView!.imageView.af.cancelImageRequest()
            headerView!.imageView.af.setImage(withURL: url, cacheKey: imageUrl)
        }
        
        return headerView!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 250)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffSetY = scrollView.contentOffset.y
        
        if contentOffSetY > 0 {
            headerView?.animator.fractionComplete = 0
            
            return
        }
        headerView?.animator.fractionComplete = abs(contentOffSetY) / 100
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let stepsExerciseVC = StepsExerciseVC()
        
        stepsExerciseVC.exercise = exerciseItems[indexPath.row]
        stepsExerciseVC.stepsJson.fetchSteps(exercise: exerciseItems[indexPath.row].id_exercise!)
        stepsExerciseVC.stepsJson.fetchContent(exercise: exerciseItems[indexPath.row].id_exercise!)
        navigationController?.pushViewController(stepsExerciseVC, animated: true)
    }
    
}


//MARK: form settings
extension ExerciseVC {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func settingsUI() {
        
        navigationItem.title = "Exercise"
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 16)!], for: .normal)
     //   navigationItem.rightBarButtonItem = self.editButtonItem
        setupCollectionView()
        setupCollectionViewLayout()
    }
    
    
    fileprivate func setupCollectionViewLayout() {
        //layout customization
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
            //отступ между ячейками
             layout.minimumLineSpacing = 5
        }
    }
    
    fileprivate func setupCollectionView() {
        
        self.collectionView!.register(ExerciseCell.self, forCellWithReuseIdentifier: cellID)
        self.collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        self.collectionView.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
        
        collectionView.contentInsetAdjustmentBehavior = .never
        
    }
    
//    override func setEditing(_ editing: Bool, animated: Bool) {
//        super.setEditing(editing, animated: true)
//
//        if editing {
//            starImage = false
//            collectionView.reloadData()
//        } else {
//            starImage = true
//            collectionView.reloadData()
//        }
   // }
    
}

