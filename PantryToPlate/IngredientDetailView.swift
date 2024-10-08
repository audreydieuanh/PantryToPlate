//
//  IngredientDetailView.swift
//  PantryToPlate
//
//  Created by Diệu Anh on 10/8/24.
//

import SwiftUI

struct IngredientDetailView: View {
    var ingredient: Ingredient
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(ingredient.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Category: \(ingredient.category)")
                .font(.title3)
                .foregroundStyle(.gray)
            
            Text("Count: \(ingredient.count)")
                .font(.title3)
                .foregroundStyle(.gray)
            
            Text("Added Date: \(formattedDate(ingredient.addDate))")
                .font(.title3)
                .foregroundStyle(.green)
            
            Text("Expiration Date: \(formattedDate(ingredient.expiryDate))")
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
        // Example ingredient for preview
        let sample = Ingredient(id: UUID(), name: "Salmon", count: 2, addDate: Date(), expiryDate: Date().addingTimeInterval(60 * 60 * 24 * 7), category: "Protein")
        IngredientDetailView(ingredient: sample)
    }
    
}
