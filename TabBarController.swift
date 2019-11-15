//
//  TabBarController.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 05/11/2019.
//  Copyright © 2019 Grinevich Sergey. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

       let exerciseGroup = ExercisesGroupTableVC()
        
        exerciseGroup.tabBarItem = UITabBarItem(title: "Упражнения", image: UIImage(named: "idumbbell-50.png")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), tag: 0)
    
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: exerciseGroup.self, action: #selector(exerciseGroup.didTapAddButton))
        navigationItem.rightBarButtonItems  = [addButton]
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: exerciseGroup.self, action:  #selector(exerciseGroup.didTapEditButton))
        navigationItem.leftBarButtonItems = [editButton]

        
        let viewControllerList = [ exerciseGroup ]
        viewControllers = viewControllerList

    }
    



}
