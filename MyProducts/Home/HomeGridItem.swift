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
            AsyncImage(url: URL(string: product.image)) { image in
                image
                    .resizable()
                    .accessibilityIdentifier("grid_image")
            } placeholder: {
                ZStack {
                    ProgressView()
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.separator)
                }
                .accessibilityIdentifier("grid_image_placeholder")
            }
            .frame(width: 100, height: 100)
            
            Text(product.title)
                .lineLimit(2)
                .accessibilityIdentifier("grid_title")
            
            Text("$\(String(format: "%.2f", product.price))")
                .fontWeight(.bold)
                .foregroundStyle(.secondary)
                .accessibilityIdentifier("grid_price")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityIdentifier("home_grid_item")
    }
}

#Preview {
    HomeGridItem(product: ProductModel(id: 1, title: "Product Name", price: 0, description: "abc", category:"a", image: ""))
}
