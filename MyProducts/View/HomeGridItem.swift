//
//  HomeGridItem.swift
//  MyProducts
//
//  Created by saboor on 07/12/2025.
//

import SwiftUI

struct HomeGridItem: View {
    let product: ProductModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let url = URL(string: product.image) {
                CachedImageView(url: url)
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .accessibilityIdentifier("grid_image")
            }
            
            Text(product.title)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .accessibilityIdentifier("grid_title")
            
            
            Text("$\(String(format: "%.2f", product.price))")
                .fontWeight(.bold)
                .foregroundStyle(.red)
                .accessibilityIdentifier("grid_price")
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityIdentifier("home_grid_item")
    }
}

#Preview {
    HomeGridItem(product: ProductModel(id: 1, title: "Product Name", price: 0, description: "abc", category:"a", image: ""))
}
