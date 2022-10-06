//
//  SwiftUIToDoListApp.swift
//  SwiftUIToDoList
//
//  Created by Lucas Barbosa de Oliveira on 20/04/22.
//

import SwiftUI

@main
struct SwiftUIToDoListApp: App {
    var body: some Scene {
        let PersistentContainer = PersistentController.shared
        
        WindowGroup {
            ContentView().environment(\.managedObjectContext, PersistentContainer.container.viewContext)
        }
    }
}
