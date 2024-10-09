//
//  IngredientDetailView.swift
//  PantryToPlate
//
//  Created by Diệu Anh on 10/8/24.
//

import SwiftUI
import CoreData

struct IngredientDetailView: View {
    @ObservedObject var ingredient: Ingredient
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(ingredient.name ?? "Unknown type")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Category: \(ingredient.category ?? "Unknown")")
                .font(.title3)
                .foregroundStyle(.gray)
            
            Text("Count: \(ingredient.count)")
                .font(.title3)
                .foregroundStyle(.gray)
            
            Text("Added Date: \(formattedDate(ingredient.addDate ?? Date()))")
                .font(.title3)
                .foregroundStyle(.green)
            
            Text("Expiration Date: \(formattedDate(ingredient.expiryDate ?? Date()))")
                .font(.title3)
                .foregroundStyle(.red)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Ingredient Details")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

struct IngredientDetailPreview: PreviewProvider {
    static var previews: some View {
        let context = DataManager.preview.persistentContainer.viewContext
        // Example ingredient for preview
        let sample = Ingredient(context: context)
        sample.id = UUID()
        sample.name = "Salmon"
        sample.count = 3
        sample.addDate = Date()
        sample.expiryDate = Date().addingTimeInterval(60 * 60 * 24 * 7)
        sample.category = "Protein"
        return IngredientDetailView(ingredient: sample)
                    .environment(\.managedObjectContext, context)
    }
    
    
}
