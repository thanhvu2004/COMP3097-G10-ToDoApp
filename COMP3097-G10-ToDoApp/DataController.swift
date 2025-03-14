//
//  DataController.swift
//  COMP3097-G10-ToDoApp
//
//  Created by Thành Vũ Lê on 2025-03-13.
//

import Foundation
import CoreData

class DataController:ObservableObject {
    let container = NSPersistentContainer(name: "MyTasks")
    
    init() {
        container.loadPersistentStores {
            description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
