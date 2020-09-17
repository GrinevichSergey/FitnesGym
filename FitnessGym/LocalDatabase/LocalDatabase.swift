//
//  LocalDatabase.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 23.05.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import Foundation
import SQLite


class LocalDatabase {
    
    static let shared = LocalDatabase()
    public let connection: Connection?
    
    private init() {
        
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("FitnessGym").appendingPathExtension("sqllite3")
            connection = try Connection(fileUrl.path)
              
//            let dbPath = Bundle.main.path(forResource: "FitnessGym", ofType: "db")!
//            connection = try Connection(dbPath)
//            self.database = database
        } catch {
            connection = nil
            print(error)
        }
        
    }
}
