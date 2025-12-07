//
//  ContentView.swift
//  MyProducts
//
//  Created by saboor on 02/12/2025.
//

import SwiftUI


struct HomeView: View {
    @StateObject var viewModel : ProductViewModel = ProductViewModel(service: NetworkManager())
    var columns : [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    var body: some View {
        NavigationStack{
            ScrollView(.vertical,showsIndicators: false){
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.products) { product in
                       HomeGridItem(product: product)
                    }
                }
            }
            .padding(.horizontal)
            .onAppear {
                viewModel.fetchAllProducts()
            }
            .navigationTitle("Products")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "plus") {
                        //
                    }
                }
            }
        }
        
    }
}
struct HomeGridItem : View {
    var product : ProductModel
    var body: some View {
        VStack(alignment: .leading,spacing: 10) {
            AsyncImage(url: URL(string: product.image)) { image in
                image
                    .resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100,height: 100)
                
                Text(product.title)
                .lineLimit(2)
                Text("$\(String(format: "%.2f", product.price))")
                .fontWeight(.bold)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
    }
}

#Preview {
    HomeView()
}
