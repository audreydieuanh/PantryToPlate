//
//  RecipeView.swift
//  PantryToPlate
//
//  Created by Diệu Anh on 10/9/24.
//

import SwiftUI

struct RecipeView: View {
    @State private var recipes: [Recipe] = []
    @State private var errorMessage: String?
    @FetchRequest(entity: Ingredient.entity(), sortDescriptors: []) var ingredients: FetchedResults<Ingredient>
    
    var body: some View {
        NavigationView {
            VStack {
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }
                
                if recipes.isEmpty {
                    Text("No recipes found. Time to go shopping for ingredients!")
                        .padding()
                } else {
                    List(recipes) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            HStack {
                                AsyncImage(url: URL(string: recipe.image)) { image in
                                    image.resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                } placeholder: {
                                    ProgressView()
                                }
                                VStack(alignment: .leading) {
                                    Text(recipe.title)
                                        .font(.headline)
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Recipes")
            .onAppear {
                fetchRecipes()
            }
        }
    }
        
        private func fetchRecipes() {
            let ingredientNames = ingredients.compactMap { $0.name }
            guard !ingredientNames.isEmpty else {
                errorMessage = "Please add ingredients first."
                return
            }
            
            RecipeAPI.shared.fetchRecipes(using: ingredientNames) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let recipes):
                        self.recipes = recipes
                    case .failure(let error):
                        self.errorMessage = "Failed to fetch recipes: \(error.localizedDescription)"
                    }
                }
            }
        }
    }
    
    struct RecipeDetailView: View {
        let recipe: Recipe
        
        var body: some View {
            VStack {
                Text(recipe.title)
                    .font(.largeTitle)
                    .padding()
                
                AsyncImage(url: URL(string: recipe.image)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                } placeholder: {
                    ProgressView()
                }
                
                Text("Used Ingredients:")
                    .font(.headline)
                    .padding(.top)
                
                ForEach(recipe.usedIngredients) { ingredient in
                    HStack {
                        AsyncImage(url: URL(string: ingredient.image)) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(formattedAmount(ingredient.amount, ingredient.unit, ingredient.name))
                    }
                }
                
                Text("Missed Ingredients:")
                    .font(.headline)
                    .padding(.top)
                
                ForEach(recipe.missedIngredients) { ingredient in
                    HStack {
                        AsyncImage(url: URL(string: ingredient.image)) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(formattedAmount(ingredient.amount, ingredient.unit, ingredient.name))
                    }
                }
                
                Spacer()
            }
        }
        
        private func formattedAmount(_ amount: Double, _ unit: String, _ name: String) -> String {
                if amount == floor(amount) {
                    return "\(Int(amount)) \(unit) \(name)"
                } else {
                    return "\(String(format: "%.2f", amount)) \(unit) \(name)"
                }
            }
    }


#Preview {
    RecipeView()
}
