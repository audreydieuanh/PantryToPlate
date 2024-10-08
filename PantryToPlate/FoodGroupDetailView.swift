//
//  FoodGroupDetailView.swift
//  PantryToPlate
//
//  Created by Diệu Anh on 10/8/24.
//

import SwiftUI

struct FoodGroupDetailView: View {
    var foodGroup: FoodGroup
    
    var body: some View {
        VStack {
            Text(foodGroup.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                    
            Text("Ingredient Count: \(foodGroup.ingredients.count)\n")
                .font(.title2)
                .padding(.top, 10)
            
            ForEach(foodGroup.ingredients) { food in
                VStack {
                    Text("\(food.name): \(food.count)\n")
                        .font(.title3)

                }}

            Spacer()
        }
        .padding()
        .navigationTitle("Food Group Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FoodGroupDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sample = [
            Ingredient(id: UUID(), name: "Apple", count: 5, addDate: Date(), expiryDate: Date().addingTimeInterval(60 * 60 * 24 * 7), category: "Fruit"), // Added today, expires in 7 days
            Ingredient(id: UUID(), name: "Banana", count: 2, addDate: Date(), expiryDate: Date().addingTimeInterval(60 * 60 * 24 * 5), category: "Fruit"), // Expires in 5 days
            Ingredient(id: UUID(), name: "Orange", count: 1, addDate: Date(), expiryDate: Date().addingTimeInterval(60 * 60 * 24 * 10), category: "Fruit") // Expires in 10 days
        ]

        let sampleFoodGroup = FoodGroup(name: "Fruits", color: Color.orange, ingredients: sample)
        FoodGroupDetailView(foodGroup: sampleFoodGroup)
    }
}
