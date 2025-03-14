//
//  COMP3097_G10_ToDoAppApp.swift
//  COMP3097-G10-ToDoApp
//
//  Created by Thành Vũ Lê on 2025-02-26.
//

import SwiftUI

@main
struct COMP3097_G10_ToDoAppApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
