//
//  DataManager.swift
//  PantryToPlate
//
//  Created by Diệu Anh on 10/8/24.
//

import CoreData
import SwiftUI
import Foundation

class DataManager: ObservableObject {
    static let shared = DataManager()
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Model")
        persistentContainer.loadPersistentStores{ description, error in
            if let error = error {
                fatalError("Error loading data. \(error)")
            }
        }
    }
    
    static var preview: DataManager = {
            let dataManager = DataManager(inMemory: true)
            let viewContext = dataManager.persistentContainer.viewContext
            let sampleIngredient = Ingredient(context: viewContext)
            sampleIngredient.id = UUID()
            sampleIngredient.name = "Salmon"
            sampleIngredient.count = 3
            sampleIngredient.addDate = Date()
            sampleIngredient.expiryDate = Date().addingTimeInterval(60 * 60 * 24 * 7)
            sampleIngredient.category = "Protein"
            
            do {
                try viewContext.save()
            } catch {
                fatalError("Unresolved error \(error)")
            }
            return dataManager
        }()
        
        init(inMemory: Bool = false) {
            persistentContainer = NSPersistentContainer(name: "Model")
            if inMemory {
                persistentContainer.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
            }
            persistentContainer.loadPersistentStores { description, error in
                if let error = error {
                    fatalError("Error loading data. \(error)")
                }
            }
        }
    
    func addIngredient(name: String, count: Int, addDate: Date, expiryDate: Date, category: String) {
        let context = persistentContainer.viewContext
        let ingredient = Ingredient(context: context)
        ingredient.id = UUID()
        ingredient.name = name
        ingredient.count = Int16(count)
        ingredient.addDate = addDate
        ingredient.expiryDate = expiryDate
        ingredient.category = category
        
        do {
            try context.save()
        } catch {
            print("Error adding ingredient. \(error)")
        }
    }
    
    func fetchIngredients() -> [Ingredient] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching ingredients. \(error)")
            return []
        }
    }
    
    func deleteIngredient(ingredient: Ingredient) {
        let context = persistentContainer.viewContext
        context.delete(ingredient)
        
        do {
            try context.save()
        } catch {
            print("Error deleting ingredient: \(error)")
        }
    }
}
