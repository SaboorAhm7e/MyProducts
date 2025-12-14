//
//  AddProductView.swift
//  MyProducts
//
//  Created by saboor on 13/12/2025.
//

import SwiftUI

struct AddProductView: View {
    // MARK: - properties
    @State var title : String = ""
    @State var price : String = ""
    @State var description : String = ""
    let categories : [String] = [
        "None",
        "Men's Fashion",
        "Women's Fashion",
        "Jewellry",
        "Electronics"
    ]
    @State var selectedCategory : String = "None"
    @EnvironmentObject var viewModel : ProductViewModel
    @Environment(\.dismiss) var dismiss
    
    // MARK: - body
    var body: some View {
        Form {
            TextField("Add Title", text: $title)
                .accessibilityIdentifier("title_field")
            TextField("$00.0", text: $price)
                .keyboardType(.numberPad)
                .accessibilityIdentifier("price_field")
            Picker("Category", selection: $selectedCategory) {
                ForEach(categories,id: \.self) {
                    Text($0)
                }
            }
            TextField("Description", text: $description, axis: .vertical)
                .accessibilityIdentifier("desc_field")
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("", systemImage: "checkmark") {
                    Task {
                        await addProduct()
                        dismiss()
                    }
                }
                .accessibilityIdentifier("btn_confirm")
            }
        }
        
    }
    // MARK: - method
    private func addProduct() async {
        let id = Int.random(in: 1...1000)
        let imageUrl = "http://apple.com"
        guard !title.isEmpty else { return }
        guard !price.isEmpty, let doubleprice = Double(price) else { return }
        guard !description.isEmpty else { return }
        guard selectedCategory != "None" else { return}
        
        let productModel : ProductModel = .init(id: id, title: title, price: doubleprice, description: description, category: selectedCategory, image: imageUrl)
        
        await viewModel.addProduct(product: productModel)
    }
}

#Preview {
    AddProductView()
}
