//
//  PantryToPlateApp.swift
//  PantryToPlate
//
//  Created by Diệu Anh on 10/8/24.
//

import SwiftUI

@main
struct PantryToPlateApp: App {
    @StateObject private var dataManager = DataManager.shared
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, dataManager.persistentContainer.viewContext)
        }
    }
}
