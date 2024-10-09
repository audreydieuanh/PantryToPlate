//
//  HomeView.swift
//  PantryToPlate
//
//  Created by Diệu Anh on 10/8/24.
//

import SwiftUI
import CoreData

struct HomeView: View {
    let foodGroups = [
        "Fruits": Color.orange,
        "Vegetables": Color.green,
        "Dairy": Color(red: 1.0, green: 0.95, blue: 0.6),
        "Protein": Color.red,
        "Grains": Color(red: 0.8, green: 0.52, blue: 0.25)]
    
    @FetchRequest(entity: Ingredient.entity(), sortDescriptors: []) var ingredients: FetchedResults<Ingredient>
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Fridge Inventory")
                        .font(.largeTitle)
                        .padding()
                    
                    NavigationLink(destination: RecipeView()) {
                        Text("Available Recipes")
                            .foregroundStyle(.primary)
                    }
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                        ForEach(foodGroups.keys.sorted(), id: \.self) { group in
                            NavigationLink(destination: FoodGroupGridView(group: group, ingredients: ingredientsForGroup(group))) {
                                VStack {
                                    Image(systemName: "fork.knife")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .padding()
                                        .foregroundStyle(foodGroups[group] ?? Color.gray)
                                    
                                    Text(group)
                                        .foregroundStyle(foodGroups[group] ?? Color.gray)
                                        .font(.headline)
                                        .padding()
                                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                        .background(foodGroups[group]?.opacity(0.2))
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                    .padding()
                    
                    NavigationLink(destination: AddView()) {
                        Text("+")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .navigationTitle("")
            }
        }
    }
    
    func ingredientsForGroup(_ group: String) -> [Ingredient] {
        return ingredients.filter { $0.category?.lowercased() == group.lowercased() }
        }
}

struct FoodGroupGridView: View {
    var group: String
    var ingredients: [Ingredient]
    
    var body: some View {
        FoodGroupDetailView(foodGroup: FoodGroup(name: group, color: .gray, ingredients: ingredients))
    }
}

struct HomePreview: PreviewProvider {
    static var previews: some View {
        let context = DataManager.preview.persistentContainer.viewContext
        HomeView()
            .environment(\.managedObjectContext, context)
    }
}
