//
//  TabBarMenuVC.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 26.04.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import UIKit

class TabBarMenuVC: UITabBarController {
    
    let exercisesGroupVC = ExercisesGroupVC()
    let trainingVC = TrainingVC()
    let favoriteVC = FavoriteVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        exercisesGroupVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Group", comment: ""), image: UIImage(named: "idumbbell-51"), tag: 0)
        trainingVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Training", comment: ""), image: #imageLiteral(resourceName: "tab-task-planning"), tag: 1)
        favoriteVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Favorite", comment: ""), image: #imageLiteral(resourceName: "tab-favorite"), tag: 2)
        
        let viewControllerList = [UINavigationController.init(rootViewController: exercisesGroupVC), UINavigationController.init(rootViewController: trainingVC), UINavigationController.init(rootViewController: favoriteVC) ]
        
        viewControllers = viewControllerList
    
    }
    

  

}
