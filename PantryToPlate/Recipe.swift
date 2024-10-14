//
//  Recipe.swift
//  PantryToPlate
//
//  Created by Diệu Anh on 10/9/24.
//

import Foundation
import Combine

struct IngredientDetail: Codable, Identifiable {
    let id: Int
    let name: String
    let amount: Double
    let unit: String
    let image: String
}

struct Recipe: Codable, Identifiable {
    let id: Int
    let title: String
    let image: String
    let usedIngredients: [IngredientDetail]
    let missedIngredients: [IngredientDetail]
}

class RecipeAPI {
    static let shared = RecipeAPI()
    private let apiKey = ""
    private var cancellables = Set<AnyCancellable>()
    
    
    func fetchRecipes(using ingredients: [String], completion: @escaping (Result<[Recipe], Error>) -> Void) {
        let ingredientString = ingredients.map { $0.lowercased() }.joined(separator: ",+")
        let urlString = "https://api.spoonacular.com/recipes/findByIngredients?ingredients=\(ingredientString)&apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else {
                    completion(.failure(URLError(.badURL)))
                    return
                }
        
        URLSession.shared.dataTaskPublisher(for: url)
                    .map { $0.data }
                    .decode(type: [Recipe].self, decoder: JSONDecoder())
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { completionResult in
                        switch completionResult {
                        case .finished:
                            break // No action needed on successful completion
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }, receiveValue: { recipes in
                        completion(.success(recipes))
                    })
                    .store(in: &cancellables)
    }
}
