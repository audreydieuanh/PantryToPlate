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
                NavigationLink(destination: IngredientDetailView(ingredient: food)) {
                    VStack(alignment: .leading) {
                        Text("\(food.name ?? "Unknown"): \(food.count)\n")
                            .font(.title3)
                            .padding(.vertical, 5)
                            .foregroundStyle(Color.primary)
                        
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Food Group Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FoodGroupDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let context = DataManager.preview.persistentContainer.viewContext
        let ingredient1 = Ingredient(context: context)
        ingredient1.id = UUID()
        ingredient1.name = "Apple"
        ingredient1.count = 5
        ingredient1.addDate = Date()
                ingredient1.expiryDate = Date().addingTimeInterval(60 * 60 * 24 * 7)
                ingredient1.category = "Fruit"
                
                let ingredient2 = Ingredient(context: context)
                ingredient2.id = UUID()
                ingredient2.name = "Banana"
                ingredient2.count = 2
                ingredient2.addDate = Date()
                ingredient2.expiryDate = Date().addingTimeInterval(60 * 60 * 24 * 5) // Expires in 5 days
                ingredient2.category = "Fruit"
                
                let ingredient3 = Ingredient(context: context)
                ingredient3.id = UUID()
                ingredient3.name = "Orange"
                ingredient3.count = 1
                ingredient3.addDate = Date()
                ingredient3.expiryDate = Date().addingTimeInterval(60 * 60 * 24 * 10) // Expires in 10 days
                ingredient3.category = "Fruit"
                
                let sampleFoodGroup = FoodGroup(
                    name: "Fruits",
                    color: Color.orange,
                    ingredients: [ingredient1, ingredient2, ingredient3]
                )
                
        return NavigationView {
            FoodGroupDetailView(foodGroup: sampleFoodGroup)
                .environment(\.managedObjectContext, context)
        }
    }
}
