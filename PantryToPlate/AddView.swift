//
//  AddView.swift
//  PantryToPlate
//
//  Created by Diệu Anh on 10/8/24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var count = 0
    @State private var expiryDate = Date()
    @State private var category = ""
    
    let categories = ["Fruits", "Vegetables", "Grain", "Protein", "Dairy"]
    
    var body: some View {
        Form {
            TextField("Ingredient Name", text: $name)
            Stepper(value: $count, in: 0...100) {
                Text("Count: \(count)")
            }
            DatePicker("Expiry Date", selection: $expiryDate, displayedComponents: .date)
            Picker("Category", selection: $category) {
                ForEach(categories, id: \.self) { category in
                    Text(category)
                }
            }
            .pickerStyle(MenuPickerStyle())
            
            Button(action: {
                DataManager.shared.addIngredient(name: name, count: count, addDate: Date(), expiryDate: expiryDate, category: category)
                
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Submit")
                    .padding()
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .frame(maxWidth: .infinity) 
            .padding()
        }
    }
}

#Preview {
    AddView()
}
