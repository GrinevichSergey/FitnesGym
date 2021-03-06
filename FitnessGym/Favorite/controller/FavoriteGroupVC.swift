//
//  FavoriteVC.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 21.05.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import UIKit
import SQLite



class FavoriteGroupVC: ExercisesGroupVC {
    
    var database: Connection!
    
    static let shared = FavoriteGroupVC()
    let favoriteTable = Table("Favorite")
    let id_favorite = Expression<Int>("id_favorite")
    let id_exercise = Expression<Int>("id_exercise")
    var favoriteItems = Array<Int>()
    
    
    override func viewDidLoad() {
        
        setupInputComponents()
        exerciseGroup.delegate = self
        database = LocalDatabase.shared.connection
        
        view.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
        navigationItem.title = "Favorite"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushExerciseGroup))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        listFavorite()
    }
    
    @objc func pushExerciseGroup() {
        self.tabBarController!.selectedIndex = 0
    }
    

    func listFavorite() {
        favoriteItems.removeAll()
        exerciseGroupItems.removeAll()
        tableView.reloadData()
        
        do {
            database = LocalDatabase.shared.connection
            let favorites = try self.database.prepare(self.favoriteTable)
            for favorite in favorites {
                favoriteItems.append(favorite[self.id_exercise])
                exerciseGroup.fetchFavoriteData(exercise_id: favorite[self.id_exercise])
               // print("id_exercise = \(favorite[self.id_exercise]), id_favorite = \(favorite[self.id_favorite])")
            }
        } catch {
            print(error)
        }

    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let exercise = FavoriteExerciseGroup()
        exercise.id_group = exerciseGroupItems[indexPath.row].idGroup!
        exercise.typesGroup = typeExercise
        exercise.imageURL = exerciseGroupItems[indexPath.row].imageURL
        self.navigationController?.pushViewController(exercise, animated: true)
    }
    
    
    func dropDatabase() {
        let fm = FileManager.default
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("Favorite").appendingPathExtension("sqllite3")
            try fm.removeItem(at: fileUrl)
            print("Database Deleted!")
        } catch {
            print("Error on Delete Database!!!")
        }
    }
    
    func updateFavorite() {
        let favorite = self.favoriteTable.filter(self.id_favorite == 1)
        let update = favorite.update(self.id_exercise <- 1)
        do {
            try self.database.run(update)
        } catch {
            print(error)
        }
        
    }
    
    func deleteFavorite() {
        let favorite = self.favoriteTable.filter(self.id_favorite == 1)
        let delete = favorite.delete()
        do {
            try self.database.run(delete)
        } catch {
            print(error)
        }
    }
    
}
